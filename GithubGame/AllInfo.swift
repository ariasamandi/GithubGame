//
//  AllInfo.swift
//  GithubGame
//
//  Created by patron on 5/10/24.
//

import SwiftUI

struct AllInfo: View {
    var userData: githubUser
    
    var body: some View {
        VStack {
            List{
                
                if let name = userData.name {
                    Text("Name: \(name)")
                }
                
                Text("Username: \(userData.login)")
                
                if let location = userData.location {
                    Text("Location: \(location)")
                }
                
                if let followers = userData.followers {
                    Text("Followers: \(followers)")
                }
                
                if let following = userData.following {
                    Text("Following: \(following)")
                }
                
                
                Text("Public repos: \(userData.public_repos ?? 0)")
                Text("Public gists: \(userData.public_gists ?? 0)")
                
                if let createdAt = userData.created_at {
                    let createdarray = createdAt.split(separator: "-")
                    let createdAtYear = createdarray[0]
                    let createdAtMonth = createdarray[1]
                    let createdAtDay = createdarray[2]
                    Text("Created: \(createdAtMonth)/\(createdAtDay.prefix(2))/\(createdAtYear)")
                }
                
                if let updatedAt = userData.updated_at {
                    let updatedarray = updatedAt.split(separator: "-")
                    let updatedAtYear = updatedarray[0]
                    let updatedAtMonth = updatedarray[1]
                    let updatedAtDay = updatedarray[2]
                    Text("Updated: \(updatedAtMonth)/\(updatedAtDay.prefix(2))/\(updatedAtYear)")
                }
            }
        }
        .padding().padding(.top, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.1))
        .ignoresSafeArea()
    }
}

struct AllInfo_Previews: PreviewProvider {
    static var previews: some View {
        // pass default user in case of nil
        AllInfo(userData: githubUser(login: "example", avatar_url: "", bio: nil, location: nil, followers: nil, following: nil, name: nil, followers_url: nil, public_repos: 0, public_gists: 0, created_at: nil, updated_at: nil))
    }
}
