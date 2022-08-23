//
//  PlaySound.swift
//  RMIT Casino
//
//  Created by Tom Huynh on 8/2/22.
//
import AVFoundation

var audioPlayer: AVAudioPlayer?
var audioBackgroundPlayer: AVAudioPlayer?
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
func playBackgroundSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioBackgroundPlayer?.numberOfLoops = -1
      audioBackgroundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioBackgroundPlayer?.play()
    } catch {
      print("ERROR: Could not find and play the sound file!")
    }
  }
}
