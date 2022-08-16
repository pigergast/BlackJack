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
            .frame(minWidth: 30, idealWidth: 50, maxWidth: 70)
            .shadow(color: .black, radius: 3)
       }
}
struct CapsuleModifier: ViewModifier{
    func body(content: Content) -> some View {
           content
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .foregroundColor(.green)
                )
       }
}
