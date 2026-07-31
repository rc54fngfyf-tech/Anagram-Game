//  ContentView.swift
//  AnagramGame
//  Created on 7/27/26.
import SwiftUI

struct ContentView: View {
    @State private var words = [String]()
    @State private var guessedWord = ""
    @State private var currentWord = ""
    @State private var isCorrectWord = false
    @State private var shuffledWord = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Guess word above", text: $guessedWord)
                        .textInputAutocapitalization(.never)
                }
            }
            .navigationTitle(shuffledWord)
            .alert("Correct Answer", isPresented: $isCorrectWord) {
                Button("OK") { startGame() }
            } message: {
                Text("Good job!")
            }
            .toolbar {
                Button("New Word") {
                    startGame()
                }
            }
            .onAppear(perform: startGame)
            .onSubmit(checkAnswer)
        }
    }
    
    func startGame() {
        guard let url = Bundle.main.url(forResource: "words", withExtension: "txt") else {
            return
        }
        
        guard let startWords = try? String(contentsOf: url, encoding: .utf8) else {
            return
        }
        
        words = startWords.components(separatedBy: "\n")
        currentWord = words.randomElement() ?? "swift"
        
        let letters = Array(currentWord)
        let shuffledLetters = letters.shuffled()
        shuffledWord = String(shuffledLetters)
        
        guessedWord = ""
    }
    
    func checkAnswer() {
        let answer = guessedWord.lowercased()
        
        if currentWord == answer {
            isCorrectWord = true
            guessedWord = ""
        }
    }
}

#Preview {
    ContentView()
}
