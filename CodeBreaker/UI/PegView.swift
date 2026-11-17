//
//  PegView.swift
//  CodeBreaker
//
//  Created by giulia on 05/10/2026.
//

import SwiftUI

struct PegView: View {
    // MARK: Data In
    let peg: Peg
    
    // MARK: - Body
    let pegShape = Circle()
    
    var body: some View {
            let optionalColor = Color(name: peg) // La tua failable initializer per i colori dei temi
            
            pegShape
            .foregroundStyle(optionalColor ?? Color.clear)
            .overlay{
                if optionalColor == nil{
                    Text(peg)
                        .font(.system(size: 120))
                        .minimumScaleFactor(9 / 120)
                }else{
                    pegShape.strokeBorder(Color.primary.opacity(0.2), lineWidth: 1)
                }
            }
            .contentShape(pegShape)
            .aspectRatio(1, contentMode: .fit)
        }
}

#Preview {
    PegView(peg: "blue")
    .padding()
}
