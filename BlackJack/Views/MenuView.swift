//
//  MenuView.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 05/08/2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Hello()) { Capsule().modifier(MenuModifier())}
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
