//
//  ViewController.swift
//  ios-cw5-p2
//
//  Created by jumana alshameri on 6/27/20.
//  Copyright © 2020 jumanaaljlewi. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
class ViewController: UIViewController {
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
        var player: AVAudioPlayer = AVAudioPlayer()
    var buttons: [UIButton] = []
    var counter = 0
    var background: AVAudioPlayer?
    var one: AVAudioPlayer?
    var tow: AVAudioPlayer?
    
    func playbackground(){
               let path = Bundle.main.path(forResource: "background.m4a", ofType: nil)!
               let url = URL(fileURLWithPath: path)

               do{
                   background = try AVAudioPlayer(contentsOf: url)
                   background?.play()
               } catch{
                   // couldn't load file
               }
           }
           // Do any additional setup after loading the view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [b1, b2, b3, b4, b5, b6, b7, b8, b9]
        playbackground()
}
    
    func playone(){
        let path = Bundle.main.path(forResource: "1.m4a", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do{
            one = try AVAudioPlayer(contentsOf: url)
            one?.play()
        } catch{
            // couldn't load file
        }
    }
    
    func playotow(){
        let path = Bundle.main.path(forResource: "2.m4a", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do{
            tow = try AVAudioPlayer(contentsOf: url)
            tow?.play()
        } catch{
            // couldn't load file
        }
    }
    
    @IBAction func buttonPress(_ sender: UIButton) {
        
        if counter % 2 == 0{
            sender.setTitle("X", for: .normal)
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
            sender.setTitleColor(.green, for: .normal)
            turnLabel.text = "O Turn..."
            playone()
        }
        else{
            sender.setTitle("O", for: .normal)
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
            sender.setTitleColor(.red, for: .normal)
             turnLabel.text = "X Turn..."
            playotow()
            
        }
        counter += 1
        sender.isEnabled = false
        
        winning(winner: "X")
        winning(winner: "O")
        
    }
    
    @IBAction func resetTapped() {
        restartGame()
    }
    
    
    func winning(winner: String)
    {
        if (b1.titleLabel?.text == winner && b2.titleLabel?.text == winner && b3.titleLabel?.text == winner) ||
           (b4.titleLabel?.text == winner && b5.titleLabel?.text == winner && b6.titleLabel?.text == winner) ||
           (b7.titleLabel?.text == winner && b8.titleLabel?.text == winner && b8.titleLabel?.text == winner) ||
           (b1.titleLabel?.text == winner && b4.titleLabel?.text == winner && b7.titleLabel?.text == winner) ||
           (b2.titleLabel?.text == winner && b5.titleLabel?.text == winner && b8.titleLabel?.text == winner) ||
           (b3.titleLabel?.text == winner && b6.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
           (b1.titleLabel?.text == winner && b5.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
           (b3.titleLabel?.text == winner && b5.titleLabel?.text == winner && b7.titleLabel?.text == winner)
        {
            
            
            let alertController = UIAlertController(title: "\(winner) has won", message: "Click on the play button to play again", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Play Again", style: .cancel) { (alert) in

                self.restartGame()

                }
                alertController.addAction(restartAction)
                present(alertController, animated: true, completion: nil)
            
        }
      
    }
        
        func restartGame()
        {
           for b in buttons
           {
            b.setTitle("", for: .normal)
            b.titleLabel?.text = ""
            b.isEnabled = true
            }
    
            counter = 0
            turnLabel.text = "X Turn..."
    }
        
    func okAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
        
    }

   
}
