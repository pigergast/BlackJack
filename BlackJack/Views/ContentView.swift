//
//  ContentView.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 05/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State var gameSave: continueGame = try! decoder.decode(continueGame.self, from:(UserDefaults.standard.object(forKey: "gameSave") as? Data ?? Data.init()))
    var body: some View {
        MenuView(gameSave: $gameSave)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
