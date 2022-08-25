/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: Userdefaults encoding and decoding from https://www.hackingwithswift.com/example-code/system/how-to-load-and-save-a-struct-in-userdefaults-using-codable
 */

import SwiftUI

struct ContentView: View {
    @State var gameSave: continueGame = try! decoder.decode(continueGame.self, from:(UserDefaults.standard.object(forKey: "gameSave") as? Data ?? defaultData))
    var body: some View {
        MenuView(gameSave: $gameSave)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
