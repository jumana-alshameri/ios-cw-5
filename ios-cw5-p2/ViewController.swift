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

    @IBOutlet weak var xScore: UILabel!
    @IBOutlet weak var oScore: UILabel!
    
        var player: AVAudioPlayer = AVAudioPlayer()
    
    var buttons: [UIButton] = []
    var counter = 0
    
    //X & O score counter
    var scoreX = 0
    var scoreO = 0
    
    //all music
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
    
    
    @IBAction func playAgain() {
        restartGame()
        restartScore()
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
            if winner == "X"{
                    self.scoreX += 1
                    self.xScore.text = String(self.scoreX)
                }
                else if winner == "O"{
                    self.scoreO += 1
                    self.oScore.text = String(self.scoreO)
                }
                
                if scoreO != 3 && scoreX != 3 {
                    let alertController = UIAlertController(title: "\(winner) has a point", message: "Click on the play button to play again", preferredStyle: .alert)
                    let restartAction = UIAlertAction(title: "Play Again", style: .cancel) { (alert) in

                        self.restartGame()

                        }
                        alertController.addAction(restartAction)
                        present(alertController, animated: true, completion: nil)
                }
                else if scoreO == 3 || scoreX == 3{
                    let alertController = UIAlertController(title: "\(winner) won 3 times!", message: "Click on the play button to play again", preferredStyle: .alert)
                               let restartAction = UIAlertAction(title: "Play Again", style: .cancel) { (alert) in

                                   self.restartGame()
                                self.restartScore()

                                   }
                                   alertController.addAction(restartAction)
                                   present(alertController, animated: true, completion: nil)
                }
            
            
            
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
            
            var backGroundColor: [UIColor] = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]
            self.view.backgroundColor = backGroundColor.randomElement()
            
    }
    
    func restartScore()
    {
        self.xScore.text = " "
        self.oScore.text = " "
        scoreO = 0
        scoreX = 0
    }
    
    func okAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
        
    }

   
}
