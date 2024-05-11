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
        Text("Hello, \(userData.login)") // Access user data from UserData
        Text("followers: \(String(describing: userData.followers))")
        Text("Folowing: \(String(describing: userData.following))")
        Text("Location: \(String(describing: userData.location))")
    }
}

struct AllInfo_Previews: PreviewProvider {
    static var previews: some View {
        AllInfo(userData: githubUser(login: "example", avatar_url: "", bio: nil, location: nil, followers: nil, following: nil, name: nil))
    }
}
