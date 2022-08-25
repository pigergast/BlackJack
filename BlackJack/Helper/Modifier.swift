/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: Based on https://github.com/TomHuynhSG/RMIT-Casino
 */

import SwiftUI

//Modifier file to contain some reused view modifiers

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
struct PlayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("New Game").foregroundColor(.white)
        }
    }
}
struct ContinueModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("Continue").foregroundColor(.white)
        }
    }
}
struct LeaderboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("Leaderboard").foregroundColor(.white)
        }
    }
}
struct SettingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("Difficulty Setting").foregroundColor(.white)
        }
    }
}
struct TutorialModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("How to play").foregroundColor(.white)
        }
    }
}

