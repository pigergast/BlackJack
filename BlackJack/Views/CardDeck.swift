/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: none
 */

import SwiftUI
//Cosmetic CardDeck View
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
