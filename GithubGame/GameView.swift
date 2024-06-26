//
//  Game.swift
//  GithubGame
//
//  Created by patron on 5/7/24.
//

import Foundation
import SwiftUI
struct GameView: View {
    @State private var question = ["How many followers does this user have?", "How many people is this user following?", "What city does this user live in?", "What State does this user live in? (Abbreviations only)"]
    @State private var answer = ""
    @State private var count = 0
    @State private var correct = 0
    @State private var feedbackMessage = ""

    var userData: githubUser

    var body: some View {
        VStack {
            Text("Welcome to the game").padding(.bottom, 100)
            
            // Game Over
            if count >= 4 {
                Text("Game Over").padding().foregroundColor(.red)
                if correct == 4{
                    Text("You Scored: \(correct)/\(count)").padding(.bottom, 20).foregroundColor(.green)
                    Text("Thats \((correct * 100 / count))%").padding(5).foregroundColor(.green)
                }
                else if correct == 3{
                    Text("You Scored: \(correct)/\(count)").padding(.bottom, 20).foregroundColor(.yellow)
                    Text("Thats \((correct * 100 / count))%").padding(5).foregroundColor(.yellow)
                }
                else if correct == 2 {
                    Text("You Scored: \(correct)/\(count)").padding(.bottom, 20).foregroundColor(.orange)
                    Text("Thats \((correct * 100 / count))%").padding(5).foregroundColor(.orange)
                }
                else{
                    Text("You Scored: \(correct)/\(count)").padding(.bottom, 20).foregroundColor(.red)
                    Text("Thats \((correct * 100 / count))%").padding(5).foregroundColor(.red)
                }
                

                Text("Play Again?").padding(10)
                Button("Yes") {
                    resetGame()
                }

                NavigationLink(destination: ContentView()) {
                    Text("No")
                }
            } 
            // Start Game
            else {
                Text("\(correct)/\(count)").foregroundColor(.green).padding()
                Text(question[count])
                TextField("Enter answer", text: $answer)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                Button("Submit") {
                    checkAnswer()
                }
                .padding()
                
                // Scan for Incorrect
                if feedbackMessage.first == "I"{
                    Text(feedbackMessage).foregroundColor(.red)
                }
                else{
                    Text(feedbackMessage).foregroundColor(.green)
                }
                
            }
        }
        .padding().frame(maxWidth: .infinity, maxHeight: .infinity).background{
            Color.green.opacity(0.1).ignoresSafeArea()
        }
    }
    
    // Check Answer
    private func checkAnswer() {
        switch(count) {
        case 0:
            if answer == String(userData.followers ?? 0) {
                // Correct
                correct += 1
                feedbackMessage = "Correct!"
            } else {
                // Incorrect
                feedbackMessage = "Incorrect. The answer is \(userData.followers ?? 0)."
            }
        case 1:
            if answer == String(userData.following ?? 0) {
                correct += 1
                feedbackMessage = "Correct!"
            } else {
                feedbackMessage = "Incorrect. The answer is \(userData.following ?? 0)."
            }
        case 2:
            let locationArray = userData.location?.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) } ?? []
            if let city = locationArray.first {
                if answer.capitalized == city {
                    correct += 1
                    feedbackMessage = "Correct!"
                } else {
                    feedbackMessage = "Incorrect. The answer is \(city)."
                }
            } else {
                feedbackMessage = "No location information available."
            }
        case 3:
            if let locationArray = userData.location?.split(separator: ",").map({ String($0.trimmingCharacters(in: .whitespaces)) }), locationArray.count >= 2 {
                let state = locationArray[1]
                if answer.uppercased() == state {
                    correct += 1
                    feedbackMessage = "Correct!"
                } else {
                    feedbackMessage = "Incorrect. The answer is \(state)."
                }
            } else {
                feedbackMessage = "No location information available."
            }
        default:
            break
        }
        count += 1
        answer = ""
    }

    private func resetGame() {
        count = 0
        correct = 0
        feedbackMessage = ""
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        // passes default user through the preview
        GameView(userData: githubUser(login: "example", avatar_url: "", bio: nil, location: nil, followers: nil, following: nil, name: nil, followers_url: nil, public_repos: 0, public_gists: 0, created_at: nil, updated_at: nil))
    }
}
