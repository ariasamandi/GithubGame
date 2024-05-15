// FollowersView

// Check our followers

import SwiftUI

struct FollowersView: View {
    var userData: githubUser
    @State private var followers: [Follower] = [] // Property to store fetched follower data

    var body: some View {
        VStack {
            Text("Followers").font(.title).fontWeight(.bold)
            
            List(followers, id: \.login) { follower in
                VStack(alignment: .leading) {
                    HStack{
                        AsyncImage(url: URL(string: follower.avatar_url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                        } placeholder: {
                            Circle()
                                .foregroundColor(.secondary)
                        }
                        .frame(width: 30, height: 30)
                        Text(follower.login)

                    }
                   
                }
            }
            .onAppear {
                // Fetch follower data when the view appears
                fetchFollowers()
            }
        }
    }

    func fetchFollowers() {
        Task {
            do {
                // Fetch follower data
                let fetchedFollowers = try await getFollowerData(url: userData.followers_url ?? "https://api.github.com/users/ariasamandi/followers") // if we have nil data we fetch Aria's followers
                // Assign fetched follower data to the property
                followers = fetchedFollowers
            } catch {
                // Handle error
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func getFollowerData(url: String) async throws -> [Follower] {
        
        // converts string to url to prepare for network request
        guard let url = URL(string: url) else {
            throw GHError.invalidURL
        }
        
        // network request using url to fetch data
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // converts network data into Follower struct
        let decoder = JSONDecoder()
        return try decoder.decode([Follower].self, from: data)
    }
}

struct Follower: Codable {
    let login: String
    let avatar_url: String
}
