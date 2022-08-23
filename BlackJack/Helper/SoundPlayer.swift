//
//  PlaySound.swift
//  RMIT Casino
//
//  Created by Tom Huynh on 8/2/22.
//
import AVFoundation

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


