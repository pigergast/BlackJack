//
//  Test.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 05/08/2022.
//

import SwiftUI

struct Test: View {
    //test
    let c: card
    var body: some View {
        c.image
        let _ = print(String(describing: c.rank) + String(describing: c.suit))
    }
}

struct Test_Previews: PreviewProvider {
    
    static var previews: some View {
        Test(c: gameDeck.drawCard())
    }
}
