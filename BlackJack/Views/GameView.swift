//
//  GameView.swift
//  BlackJack
//
//  Created by Oggy on 16/08/2022.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        VStack{
            HStack{
                Image("BACK")
                Image("BACK")
                Image("BACK")
            }
            Spacer()
            HStack{
                Image("BACK").resizable()
                    .scaledToFit()
                    .frame(minWidth: 20, idealWidth: 40, maxWidth: 100)
                    .shadow(color: .black, radius: 3)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
