//
//  Modifiers.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 05/08/2022.
//

import Foundation
import SwiftUI

struct MenuModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("Play").foregroundColor(.white)
        }
    }
}
