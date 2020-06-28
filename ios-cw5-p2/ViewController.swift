//
//  ViewController.swift
//  ios-cw5-p2
//
//  Created by jumana alshameri on 6/27/20.
//  Copyright © 2020 jumanaaljlewi. All rights reserved.
//

import UIKit
import AVFoundation
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [b1, b2, b3, b4, b5, b6, b7, b8, b9]
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonPress(_ sender: UIButton) {
        
        if counter % 2 == 0{
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.black, for: .normal)
            turnLabel.text = "O Turn..."
        }
        else{
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.white, for: .normal)
             turnLabel.text = "X Turn..."
            
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
            
            
            let alertcontroller = UIAlertController(title: "\(winner) فاز", message: "قم بضغط الزر التالي كي يتم إعادة اللعب", preferredStyle: .alert)
            let restartaction = UIAlertAction(title: "إعادة اللعب", style: .cancel) { alert in self.restartGame()}
            
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
        func playMusic(musicName: String, type: String, loop: Int = 0)
        {
            let AssortedMusics = URL(fileURLWithPath: Bundle.main.path(forResource: musicName, ofType: type)!)
            player = try! AVAudioPlayer(contentsOf: AssortedMusics)
            player.prepareToPlay()
            player.numberOfLoops = loop
            player.volume = 0.5
            player.play()
        }


    
    
    


   
}
