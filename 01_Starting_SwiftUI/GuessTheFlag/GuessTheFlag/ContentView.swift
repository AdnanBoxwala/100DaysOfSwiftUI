//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Adnan Boxwala on 11.09.23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    private let maxQuestionCount = 8
    @State private var answeredQuestions = 0
    @State private var gameOver = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var selectedFlag = -1
    @State private var restOpacity = 1.0
    @State private var restScale = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                Gradient.Stop(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                Gradient.Stop(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .prominentTitle(Color(red: 0.76, green: 0.15, blue: 0.26), .largeTitle.bold())
//                    .font(.largeTitle.bold())
//                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(for: countries[number])
                                .rotation3DEffect(
                                    Angle(degrees: selectedFlag == number ? 360 : 0),
                                                          axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                                .opacity(selectedFlag != number ? restOpacity : 1)
                                .scaleEffect(selectedFlag != number ? restScale : 1)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .prominentTitle(Color(red: 0.1, green: 0.2, blue: 0.45), .title.bold())
//                    .foregroundColor(.white)
//                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("Start again", action: reset)
        } message: {
            Text(" Final Score: \(score) / \(maxQuestionCount)")
        }
    }
    
    func flagTapped(_ number: Int) {
        withAnimation {
            selectedFlag = number
            restOpacity = 0.25
            restScale = 0.8
        }
        
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
            score = score > 0 ? score - 1 : 0
        }
        
        answeredQuestions += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showingScore = true
        }
    }
    
    func askQuestion() {
        if answeredQuestions == maxQuestionCount {
            gameOver = true
            return
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        // reset animation properties
        selectedFlag = -1
        restOpacity = 1
        restScale = 1
    }
    
    func reset() {
        answeredQuestions = 0
        score = 0
        askQuestion()
    }
    
    func FlagImage(for country: String) -> some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
