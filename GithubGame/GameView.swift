//
//  Game.swift
//  GithubGame
//
//  Created by patron on 5/7/24.
//

import Foundation
import SwiftUI
struct GameView: View{
    @State private var question = ["How many followers does this user have?", "How many people is this user following?", "What city does this user live in?", "What State does this user live in? (Abbrieviations only)"]
    @State private var answer = ""
    @State private var count = 0
    @State private var correct = 0
    var body: some View{
        VStack{
            Text("Welcome to the game").padding(.bottom, 100)
            if count >= 4{
                Text("Game Over").padding().foregroundColor(.red)
                Text("You Scored: \(correct)/\(count)").padding(.bottom, 20).foregroundColor(.green)
                Text("Thats \((correct/count)*100)%").padding(5)
                Text("Play Again?").padding(10)
                Button("Yes"){
                    count = 0
                    correct = 0
                }
                Button("No"){
                    count = 0
                    correct = 0
                }
            }
            else{
                Text("\(correct)/\(count)").foregroundColor(.green).padding()
                Text(question[count])
                TextField("Enter answer", text: $answer).frame(width: 300, height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                Button("Submit") {
                    // Use the entered username (stored in `username` variable)
                    switch(count){
                    case 0:
                        if answer == "14"{
                            correct += 1
                            
                        }
                        answer = ""
                        break
                    case 1:
                        if answer == "18"{
                            correct += 1
                        
                        }
                        answer = ""
                        break
                    case 2:
                        if answer == "Pacific Palisades"{
                            correct += 1
                
                        }
                        answer = ""
                        break
                    case 3:
                        if answer == "CA"{
                            correct += 1
            
                        }
                        answer = ""
                    default:
                        correct = 0
                        answer = ""
                        break
                    }
                    
                    print("Username: \(answer)")
                    count += 1
                }
            }
            
            
        }
    }
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
