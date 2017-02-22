//
//  ViewController.swift
//  Scribe
//
//  Created by LionMane Software on 2/22/17.
//  Copyright © 2017 LionMane Software. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true
        
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    func requestSpeechAuth(){
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do{
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    }catch let err as NSError{
                        print(err.debugDescription)
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request){
                        (result, error) in
                        if let error = error{
                            print("there was an error \(error)")
                        }else{
                            print(result?.bestTranscription.formattedString ?? "")
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString ?? ""
                            
                        }
                    }
                    
                    
                }
            }
        }
    }

    @IBAction func recognizerBtnPress(_ sender: CirlceButton) {
        spinner.isHidden = false
        spinner.startAnimating()
        requestSpeechAuth()
        
    }
}

