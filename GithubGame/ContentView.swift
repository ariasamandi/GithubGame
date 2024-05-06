//
//  ContentView.swift
//  GithubGame
//
//  Created by patron on 5/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var user: githubUser?
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: user?.avatar_url ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }placeholder:{
                Circle()
                    .foregroundColor(.secondary)
                    
            }
            .frame(width: 120, height: 120)
            Text(user?.login ?? "Login Placeholder").bold().font(.title3)
            Text(user?.bio ?? "Bio Placeholder").padding()
            
            Spacer()
            Text("Want to play a game")
            Link("Yes",
                  destination: URL(string: "https://www.example.com/TOS.html")!)

        }
        .padding().padding()
        .task {
            do{
                user = try await getUser()
            }catch GHError.invalidURL{
                print("invalid url")
                
            } catch GHError.invalidData{
                print("invalid data")
            } catch GHError.invalidResponse{
                print("invalid response")
            } catch{
                print("unexpected error")
            }
        }
    }
    func getUser() async throws -> githubUser{
        let endpoint = "https://api.github.com/users/ariasamandi"
        guard let url = URL(string: endpoint) else{
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw GHError.invalidResponse
        }
        do{
            let decoder = JSONDecoder()
            return try decoder.decode(githubUser.self, from: data)
        } catch{
            throw GHError.invalidData
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct githubUser: Codable{
    let login: String
    let avatar_url: String
    let bio: String
}
enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
