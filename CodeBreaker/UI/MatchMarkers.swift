//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by guilia on 10/09/2026.
//
import SwiftUI

enum Match{
    case nomatch
    case exact
    case inexact
}


struct MatchMarkers: View {
    // MARK: Data in
    let matches: [Match]
    
    //MARK: - Body
    var body: some View {
        HStack{
            VStack{
                matchMaker(peg: 0)
                matchMaker(peg: 1)

                
                //Circle().fill(Color.green)
                //Circle().strokeBorder(Color.primary, lineWidth: 3)
                  //  .aspectRatio(1, contentMode: .fit)
            }
            VStack{
                matchMaker(peg: 2)
                matchMaker(peg: 3)

                //Circle()
                //Circle().opacity(0)
            }
            VStack{
                matchMaker(peg: 4)
                matchMaker(peg: 5)
            }
        }
    }
    @ViewBuilder
    func matchMaker(peg: Int)-> some View{
        let exactCount: Int = matches.count(where: {match in match == .exact}) // chat dice:
        //let exactCount = matches.filter { $0 == .exact }.count
        let foundCount: Int = matches.count(where: {match in match != .nomatch}) // chat dice:
        //let foundCount = matches.filter { $0 != .nomatch }.count
        Circle()
            .fill(exactCount > peg ? Color.primary: Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary: Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
            
    }
}
struct MatchMarkersPreview: View{
    let matches: [Match]
    var body: some View{
        HStack{
            ForEach(matches.indices, id: \.self){ _ in
                Circle()
            }
        
            MatchMarkers(matches: matches)
            
        }
    }
}


#Preview {
    
    /*VStack{
        HStack{
            MatchMarkers(matches: [
                .exact, .inexact, .nomatch
            ])
        
        }
        
       
    }*/
    
    VStack{
        MatchMarkersPreview(matches: [.exact, .inexact, .exact, .exact, .exact, .inexact])
        MatchMarkersPreview(matches: [.exact, .inexact, .nomatch])

    }
}
