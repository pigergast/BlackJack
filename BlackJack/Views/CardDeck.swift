//
//  CardDeck.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 19/08/2022.
//

import SwiftUI

struct CardDeck: View {
    var body: some View {
        ZStack {
            Image("BACK").resizable().modifier(CardModifier())
            Image("BACK").resizable().modifier(CardModifier()).offset(x: 3)
            Image("BACK").resizable().modifier(CardModifier()).offset(x: 6)
        }
    }
}

struct CardDeck_Previews: PreviewProvider {
    static var previews: some View {
        CardDeck()
    }
}
