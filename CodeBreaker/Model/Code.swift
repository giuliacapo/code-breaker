//
//  Code.swift
//  CodeBreaker
//
//  Created by giulia on 05/10/2026.
//


import Foundation

struct Code{
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)
    
    static let missing: Peg = ""
    enum Kind: Equatable{ // put a time inside another tipe is beacuse if you refer from it from outside you have to say code.kind
        case master (isHidden: Bool)
        case guess
        case attempt ([Match])
        case unknown
    }
    init(kind: Kind = .guess, pegCount: Int = 4){
        self.kind = kind
        self.pegs = Array(repeating: Code.missing, count: pegCount)
    }
    
    mutating func randomize(from pegChoises: [Peg]){
        for index in pegs.indices{
            pegs[index] = pegChoises.randomElement() ?? Code.missing
        }
    }
    var isHidden: Bool{
        switch kind{
        case .master(let isHidden): return isHidden
        default: return false 
        }
    }
        
    mutating func reset(){
        pegs = Array(repeating: Code.missing, count: pegs.count)
    }
    
    var matches: [Match]? {
        switch kind{
        case .attempt(let matches): return matches
        default: return nil
        }
    }
    
    func match(aginst otherCode: Code)->[Match]{
        var pegsToMatch = otherCode.pegs
        
        let backwardsExactMatches = pegs.indices.reversed().map{index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index]{
                pegsToMatch.remove(at: index)
                return Match.exact
            }else{
                return .nomatch //capisce dall altro return cosa sta ritornando
            }
            
        }
        let exactMatches = Array(backwardsExactMatches.reversed())// non era un array prima
        return pegs.indices.map{index in
            if exactMatches[index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]){
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            }else{
                return exactMatches[index]
            }
        }
    }
}
