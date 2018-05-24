//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Adam Myhre on 2018-05-24.
//  Copyright © 2018 undergalaxie.com. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var playButton: UIButton!    
    @IBOutlet weak var addButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupRecorder()
        playButton.isEnabled = false
    }
    
    func setupRecorder () {
        do {
        // Create audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create url for audio file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            // Create settings for audio recorder
            var settings : [String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            // Create audio recorder object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder?.prepareToRecord()
            
        } catch {}
    }

    @IBAction func recordTapped(_ sender: Any) {
        if (audioRecorder!.isRecording) {
            // Stop the recording
            audioRecorder?.stop()
            
            // Change button title to Record and enable Play
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true

        } else {
            // Start the recording
            audioRecorder?.record()
            
            // Change the button title to Stop
            recordButton.setTitle("Stop", for: .normal)
            
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch {}
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
}
