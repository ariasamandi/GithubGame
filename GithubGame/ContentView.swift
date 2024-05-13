import SwiftUI


struct ContentView: View {
    @State var userData: githubUser? // Use @StateObject for observable object
    @State private var username = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                if userData != nil {
                    // Display user data if available
                    AsyncImage(url: URL(string: userData?.avatar_url ?? "default")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 120, height: 120)
                    Text(userData?.login ?? "default").bold().font(.title3)
                    if let bio = userData?.bio {
                        Text(bio).padding().padding(.bottom, 70)
                    }
                } else {
                    // Show placeholder views when user data is not available
                    Circle()
                        .foregroundColor(.secondary)
                        .frame(width: 120, height: 120)
                    Text("Login Placeholder").bold().font(.title3)
                    Text("Bio Placeholder").padding().padding(.bottom, 70)
                }
                
                Text("Enter a Github Username")
                TextField("Enter your username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                Button("Submit") {
                
                    print("Username: \(username)")
                    
                    // Call getUser to fetch user data
                    getUser(username: username)
                }
                
                Spacer()
                if (userData == nil){
                    Text("Followers").foregroundColor(.gray)
                }
                else{
                    NavigationLink(destination: FollowersView(userData: userData!)) {
                        Text("Followers").foregroundColor(.blue)
                    }
                }
                if (userData == nil){
                    Text("All Info").foregroundColor(.gray)
                }
                else{
                    NavigationLink(destination: AllInfo(userData: userData!)) {
                        Text("AllInfo").foregroundColor(.blue)
                    }
                }
                
                Text("Want to play a game")
                if (userData == nil){
                    Text("Yes").foregroundColor(.gray)
                }
                else{
                    NavigationLink(destination: GameView(userData: userData!)) {
                        Text("Yes").foregroundColor(.blue)
                    }
                }
            }
            .padding().padding().background{
                Color.orange.opacity(0.3).ignoresSafeArea()
            }
            
        }
        
    }
    
    func getUser(username: String) {
        Task {
            do {
                // Fetch user data
                let user = try await getUserData(username: username)
                userData = user // Assign fetched user data to userData
            } catch {
                // Handle error
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getUserData(username: String) async throws -> githubUser {
        let endpoint = "https://api.github.com/users/\(username)"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        let decoder = JSONDecoder()
        return try decoder.decode(githubUser.self, from: data)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct githubUser: Codable {
    let login: String
    let avatar_url: String
    let bio: String?
    let location: String?
    let followers: Int?
    let following: Int?
    let name: String?
    let followers_url: String?
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
