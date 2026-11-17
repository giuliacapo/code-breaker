//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by giulia on 19/09/2026.
//

import Foundation

//typealias Peg = Color no beacuse color is ui thing, model must me ui indipendent
typealias Peg = String


struct CodeBreaker{
    var mastercode: Code = Code(kind: .master(isHidden: true))
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = [Code]()
    var pegChoices: [Peg]
    var pegCount: Int
    var currentThemeName: String = "Classic Colors"
        
    static let themes: [String: [Peg]] = [
        "Classic Colors": ["red", "blue", "green", "yellow", "orange", "purple", "white"],
        "Earth Tones": ["brown", "orange", "yellow", "green", "pink"],
        "Faces": ["😀", "🤪", "🥳", "😨", "😎", "🤩"],
        "Vehicles": ["🚗", "🚲", "✈️", "⛵", "🚀", "🚁"]
    ]
    
    init(pegCount: Int){
        self.pegCount = pegCount
        if let randomTheme = CodeBreaker.themes.randomElement(){
            currentThemeName = randomTheme.key
            pegChoices = Array(randomTheme.value.shuffled().prefix(pegCount))
        }else {
            self.currentThemeName = "Classic Colors"
            self.pegChoices = ["red", "blue", "green", "yellow"]
        }
        self.mastercode = Code(kind: .master(isHidden: true), pegCount: pegCount)
        self.guess = Code(kind: .guess, pegCount: pegCount)
        mastercode.randomize(from: pegChoices)
        print(mastercode)
    }
    
    var isOver: Bool{
        attempts.last?.pegs == mastercode.pegs
    }
    
    mutating func attemptGuess(){
        var attempt = guess
        attempt.kind = .attempt(guess.match(aginst: mastercode))
        // se sono tutte non nulle e se non è già stato tentato (= non appartiene all'array che contiene tutti i tentativi)
        let alreadyTried = attempts.contains(where: {$0.pegs == guess.pegs})
        if !guess.pegs.contains(Code.missing) && !alreadyTried
        {
            attempts.append(attempt)
            guess.reset()
        }
        if isOver{
            mastercode.kind = .master(isHidden: false)
        }
    }
    
    mutating func setGuessPeg(_ peg:Peg, at index: Int){
        guard guess.pegs.indices.contains(index) else{ return }
        guess.pegs[index] = peg
    }
    
    mutating func changeGuessPeg(at index: Int){
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg){
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices+1)%pegChoices.count]
            guess.pegs[index] = newPeg
        }else{
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
        
    }
    mutating func restart(){
        pegCount = Int.random(in: 3 ... 6)
        if let randomTheme = CodeBreaker.themes.randomElement(){
            currentThemeName = randomTheme.key
            pegChoices = Array(randomTheme.value.shuffled().prefix(pegCount))
            
        }
        mastercode = Code(kind: .master(isHidden: true), pegCount: pegCount)
        mastercode.randomize(from: pegChoices)
        guess = Code(kind: .guess, pegCount: pegCount)
        attempts.removeAll()
    }
}



