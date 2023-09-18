//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Adnan Boxwala on 17.09.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userChoices = ["rock", "paper", "scissors"]
    @State private var winMoves = ["paper", "scissors", "rock"]
    @State private var lossMoves = ["scissors", "rock", "paper"]
    @State private var botChoice = Int.random(in: 0...2)
    @State private var userShouldWin: Bool = Bool.random()
    
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var showingScore = false
    
    private let maxQuestionCount = 10
    @State private var answeredQuestions = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.teal, .gray], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)
                    .padWithSpacer()
                
                VStack {
                    HStack {
                        botPick()
                    }
                    .padding(.vertical)
                    
                    HStack {
                        userPromt()
                    }
                    .padding(.vertical)
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                motifTapped(userChoices[number])
                            } label: {
                                buttonMotif(of: userChoices[number])
                            }
                        }
                        .padWithSpacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.primary)
                    .padWithSpacer()
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Next question", action: nextRound)
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("Start over", action: reset)
        } message: {
            Text("Your final score is \(score)!")
        }
    }
    
    private func nextRound() {
        if answeredQuestions == maxQuestionCount {
            gameOver = true
            return
        }
        botChoice = Int.random(in: 0...2)
        userShouldWin = Bool.random()
    }
    
    private func reset() {
        answeredQuestions = 0
        score = 0
        nextRound()
    }
    
    private func motifTapped(_ choice: String) {
        switch userShouldWin {
        case true:
            if choice == winMoves[botChoice] {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong"
                score = score - 1 < 0 ? 0 : score - 1
            }
        case false:
            if choice == lossMoves[botChoice] {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong"
                score = score - 1 < 0 ? 0 : score - 1
            }
        }
        showingScore = true
        answeredQuestions += 1
    }
    
    private func buttonMotif(of object: String) -> some View {
        VStack {
            Image(object)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(object.capitalized)
                .font(.title3)
                .foregroundColor(.primary)
        }
    }
    
    private func botPick() -> some View {
        Group {
            Text("Bot's move: ")
                .font(.title3)
            Text(userChoices[botChoice].uppercased())
                .font(.title2.bold())
        }
    }
    
    private func userPromt() -> some View {
        Group {
            Text("Make your move to")
                .font(.title3)
            Text("\(userShouldWin ? "WIN" : "LOSE")")
                .font(.title2.bold())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
