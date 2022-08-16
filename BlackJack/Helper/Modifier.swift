//
//  Modifier.swift
//  BlackJack
//
//  Created by Oggy on 16/08/2022.
//

import SwiftUI

struct CardModifier: ViewModifier{
    func body(content: Content) -> some View {
           content
            .scaledToFit()
            .frame(minWidth: 20, idealWidth: 40, maxWidth: 50)
            .shadow(color: .black, radius: 3)
       }
}
