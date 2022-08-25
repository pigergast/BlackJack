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

import AVFoundation
//Audio player for use in game actions and background music playin
//There are multiple because sometimes sounds are played on top of each other, i.e background music and action sound effect
var audioPlayer: AVAudioPlayer?
var audioPlayer2: AVAudioPlayer?
var audioPlayer3: AVAudioPlayer?
func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}
func playSound2(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer2?.numberOfLoops = -1
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer2?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}
func playSound3(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer3?.numberOfLoops = -1
            audioPlayer3 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer3?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}


