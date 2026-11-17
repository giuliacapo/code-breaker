//
//  PegChooser.swift
//  CodeBreaker
//
//  Created by giulia on 13/10/2026.
//

import SwiftUI

struct PegChooser: View {
    //MARK: Data in
    let choises: [Peg]
    
    //MARK: Data out Function
    let onChose: ((Peg) -> Void)?
    
    //MARK: - Body
    
    var body: some View {
        HStack{
            ForEach(choises, id: \.self){ peg in
                Button{
                    onChose?(peg)
                }label:{
                    PegView(peg: peg)
                }
            }
        }    }
}

//#Preview {
  //  PegChooser()
//}
