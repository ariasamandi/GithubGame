import SwiftUI

struct ContentView: View {
    @State private var user: githubUser? = nil
    @State private var username = ""
    
    var body: some View {
        NavigationView{
            
            
            VStack(spacing: 20) {
                if let user = user {
                    // Display user data if available
                    AsyncImage(url: URL(string: user.avatar_url)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 120, height: 120)
                    Text(user.login).bold().font(.title3)
                    if user.bio != ""{
                        Text(user.bio).padding().padding(.bottom, 70)
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
                    // Use the entered username (stored in `username` variable)
                    print("Username: \(username)")
                    
                    // Call getUser to fetch user data
                    getUser(username: username)
                }
                
                Spacer()
                
                Text("Want to play a game")
                NavigationLink(destination: Game()) {
                    Text("Yes").foregroundColor(.blue)
                }
            }
            .padding().padding()
//            .navigationTitle("Main Screen")
        }
    }
    func getUser(username: String) {
        Task {
            do {
                // Fetch user data
                user = try await getUserData(username: username)
                print("name: \(user?.name ?? "nil")") // Print name after setting user
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
    let bio: String
    let location: String
    let followers: Int
    let following: Int
    let name: String
    
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
