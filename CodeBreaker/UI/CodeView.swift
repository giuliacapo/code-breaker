//
//  CodeView.swift
//  CodeBreaker
//
//  Created by giulia on 13/10/2026.
//

import SwiftUI

struct CodeView<AncillaryView>: View where AncillaryView: View{
    //MARK: Data In
    let code: Code
    
    //MARK: Data Shared with me
    @Binding var selection: Int
    
    
    //MARK: Data (sort of) IN Function
    @ViewBuilder let ancillaryView: () -> AncillaryView
    
    //MARK: Data Owned By Me
    @Namespace private var selectionNameSpace
    
    init(
        code: Code,
        selection: Binding<Int> = .constant(-1),
    @ViewBuilder ancillaryView: @escaping () -> AncillaryView = {EmptyView()}
    ) {
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
    
    //MARK: - Body
    var body: some View {
        HStack{
            ForEach(0..<code.pegs.count, id: \.self) { index in
                PegView(peg: code.pegs[index])
                    .padding(Selection.border)
                    .background{ //selection background
                        Group{
                            if selection == index, code.kind == .guess {
                                Selection.shape.foregroundStyle(Selection.color)
                                    .matchedGeometryEffect(id: "selection", in: selectionNameSpace)
                            }
                        }
                        .animation(.selection, value: selection)
                    }

                    .overlay{//hidden code obscuring
                        Selection.shape.foregroundStyle(code.isHidden ? Color.gray : .clear)
                            .transaction{ transaction in
                                if code.isHidden{
                                    transaction.animation = nil
                                }
                            }
                    }
                
                    .onTapGesture {
                        if code.kind == .guess{
                            selection = index
                        }
                    }
            }
            Rectangle().foregroundStyle(Color.clear).aspectRatio(1, contentMode: .fit)
                .overlay{
                    ancillaryView()
                }
            }
        

        
        
    }
    
}
fileprivate struct Selection{
    static let border: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let color = Color.gray(0.85)
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
}

//#Preview {
  //  CodeView()
//}
