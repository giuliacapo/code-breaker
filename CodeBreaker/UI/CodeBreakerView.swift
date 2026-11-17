//
//  ContentView.swift
//  CodeBreaker
//
//  Created by giulia on 08/09/2026.
//

import SwiftUI

// cambia da contenview a codebreaker view
struct CodeBreakerView: View {
    //devo inserire i bottoni che permettono di selezionare quante peg voglio in base al numero che schiaccio passo quel numero qui sotto
    
   // MARK: Data Owned By Me
    @State private var selectedPegCount: Int = 4
    @State private var game: CodeBreaker = CodeBreaker(pegCount: 4)
    @State private var selection: Int = 0
    @State private var restarting = false
    @State private var hideMostRecentMarkers = false
    
    // MARK: - Body
    var body: some View {
        VStack{
            Text("Theme: \(game.currentThemeName)")
                .font(.headline)
                .foregroundColor(.secondary)
            HStack{
                Text("Select numer of pegs: ")
                ForEach(3...6, id: \.self){ count in
                    Button("\(count)"){
                        selectedPegCount = count
                        withAnimation {
                            game = CodeBreaker(pegCount: count)
                            selection = 0
                        }
                    }
                    .buttonStyle(.bordered)
                    .disabled(selectedPegCount == count)
                }
                Button("Restart Game", systemImage: "arrow.circlepath", action: restart)
            }
            CodeView(code: game.mastercode)
            ScrollView{
                if !game.isOver || restarting{
                    CodeView(code: game.guess, selection: $selection){
                        Button("Guess", action: guess).flexibleSystemFont()
                    }
                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting ? 0 : 1)

                }
                ForEach(game.attempts.indices.reversed(), id: \.self){index in
                    CodeView(code: game.attempts[index]){
                        let showMarkers = !hideMostRecentMarkers || index != game.attempts.count - 1
                        if showMarkers, let matches = game.attempts[index].matches{
                            MatchMarkers(matches: matches)
                        }
                    }
                    .transition(.attempt(game.isOver))
                }
            }
            if !game.isOver{
                PegChooser(choises: game.pegChoices, onChose: changePegAtSelection)
                    .transition(.pegChooser)
            }
            
        }
                .padding()
    }
    func changePegAtSelection(to peg: Peg){
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1) % game.mastercode.pegs.count
    }
    
    func guess(){
        withAnimation(Animation.guess){
            game.attemptGuess()
            selection = 0
            hideMostRecentMarkers = true
        }completion: {
            withAnimation(.guess){
                hideMostRecentMarkers = false
            }
        }

    }
    
    func restart(){
        withAnimation(.restart){
            restarting = true
        }completion: {
            withAnimation (.restart){
                game.restart()
                selection = 0
                restarting = false
            }
        }
        
    }
    
   
    struct Selection{
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    }
}




#Preview {
    CodeBreakerView()
}


