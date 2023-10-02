//
//  ContentView.swift
//  TimesX
//
//  Created by Adnan Boxwala on 26.09.23.
//

import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    @State private var gameStarted = false
    @State private var gameOver = false
    @FocusState private var amountIsFocused: Bool
    
    @State private var number = 5
    
    let sizeOptions = [5, 10, 15]
    @State private var questionCount = 5
    @State private var questions: [Question] = []
    @State private var currentQuestionCount = 1 // skips question at 0th index
    
    @State private var answer: Int? = nil
    @State private var isCorrectAnswer = false
    
    @State private var score = 0
    @State private var showResult = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    
    var body: some View {
        if gameStarted {
            gameView
        } else {
            settingsView
        }
    }
 
    var gameView: some View {
        NavigationView {
            ZStack {
                Image("TimesX_game")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.2)
                
                VStack {
                    Spacer()
                    
                    Text("\(currentQuestionCount) / \(questionCount)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        .background()
                    
                    Spacer()
                    
                    questionView
                    
                    Spacer()
                    
                    answerField
                    
                    Text("Score: \(score)")
                        .font(.title.bold())
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
            .navigationTitle("TimesX")
            .toolbar {
                Button("New game", action: newGame)
                    .padding(5)
                    .background(.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Button("Restart", action: restart)
                    .padding(5)
                    .background(.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Submit") {
                        amountIsFocused = false
                        verifyAnswer()
                    }
                    .font(.body)
                    .disabled(answer == nil)
                }
            }
            .alert(alertTitle, isPresented: $showResult) {
                Button("Next") {
                    withAnimation {
                        askQuestion()
                    }
                }
            } message: {
                Text(alertMessage)
            }
            .alert(alertTitle, isPresented: $gameOver) {
                Button("Continue learning.", action: newGame)
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    var questionView: some View {
        Group {
            Text("What is...")
                .font(.title3)
            
            Text("\(questions[currentQuestionCount].text)?")
                .font(.title.bold())
        }
    }
    
    var answerField: some View {
        TextField("Answer", value: $answer, format: .number)
            .font(.largeTitle)
            .padding()
            .background(showResult ? (isCorrectAnswer ? .green : .red ) : .cyan)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
            .multilineTextAlignment(.center)
            .animation(.default, value: isCorrectAnswer)
    }
    
    var settingsView: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.orange, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Form {
                        Section {
                            Stepper("\(number)", value: $number, in: 2...12)
                        } header: {
                            Text("Practice tables upto?")
                                .foregroundStyle(.thickMaterial)
                                .font(.headline)
                        }
                        
                        Section {
                            Picker("Number of questions", selection: $questionCount) {
                                ForEach(sizeOptions, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                        } header: {
                            Text("Number of questions")
                                .foregroundStyle(.thickMaterial)
                                .font(.headline)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                    Button("Start", action: startGame)
                        .font(.title)
                        .padding(40)
                        .background(.orange)
                        .clipShape(Circle())
                }
                .padding()
            }
            .navigationTitle("TimesX")
        }
    }
    
    private func startGame() {
        gameStarted = true
        for multiplier in Array(1...12) {
            for practiceNumber in Array(1...number) {
                let question = Question(
                    text: "\(practiceNumber) x \(multiplier)",
                    answer: practiceNumber * multiplier)
                questions.append(question)
            }
        }
        questions.shuffle()
    }
    
    private func newGame() {
        gameStarted = false
        currentQuestionCount = 1
        answer = nil
        score = 0
        questions = []
    }
    
    private func restart() {
        currentQuestionCount = 1
        answer = nil
        score = 0
        questions.shuffle()
    }
    
    private func askQuestion() {
        if currentQuestionCount < questionCount {
            currentQuestionCount += 1
            answer = nil
            return
        }
        gameOver = true
        alertTitle = "Game Over!"
        alertMessage = "Your final score is \(score) / \(questionCount)."
    }
    
    private func verifyAnswer() {
        if answer == questions[currentQuestionCount].answer {
            alertTitle = "Great work!"
            alertMessage = "That's the right answer."
            isCorrectAnswer = true
            score += 1
        } else {
            alertTitle = "Oops.."
            alertMessage = "The correct answer is \(questions[currentQuestionCount].answer)."
            isCorrectAnswer = false
        }
        showResult = true
    }
}

#Preview {
    ContentView()
}
