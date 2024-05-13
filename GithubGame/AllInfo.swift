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
        VStack{
            Text("Hello, \(userData.login)") // Access user data from UserData
            Text("followers: \(String(describing: userData.followers))")
            Text("Folowing: \(String(describing: userData.following))")
            Text("Location: \(String(describing: userData.location))")
        }
        .padding().padding().frame(maxWidth: .infinity, maxHeight: .infinity).background{
            Color.black.opacity(0.1).ignoresSafeArea()
        }
       
    }
}

struct AllInfo_Previews: PreviewProvider {
    static var previews: some View {
        AllInfo(userData: githubUser(login: "example", avatar_url: "", bio: nil, location: nil, followers: nil, following: nil, name: nil, followers_url: nil))
    }
}
