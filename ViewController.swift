//
//  ViewController.swift
//  CatchTheKennyApp
//
//  Created by Ömer Tuğrul on 18.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kenneyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0

    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var highscorelabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //highscore kontrol et
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighscore == nil{
            highScore = 0
            highscorelabel.text = "Highscore \(highScore)"
        }
        
        if let newScore = storedHighscore as? Int{
            highScore = newScore
            highscorelabel.text = "Highscore: \(highScore)"
        }
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kenneyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
        
        // Do any additional setup after loading the view.
    }
    
   @objc func hideKenny(){
        for kenny in kenneyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kenneyArray.count-1)))
        kenneyArray[random].isHidden = false
    }
    
    @objc func increasescore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            for kenny in kenneyArray{
                kenny.isHidden = true
                
                
        //Highscore ekle
                
                if self.score > self.highScore{
                    self.highScore = self.score
                    highscorelabel.text = "Highscore : \(self.highScore)"
                    
                    UserDefaults.standard.set(self.highScore, forKey: "highscore")
                
                }
            
            
            // insert alert here
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                    
                    self.score = 0
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.counter = 10
                    self.timeLabel.text =  String (self.counter)
                
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                    self.hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                    //timerı kopyalıyorum çünkü tekrardan başlayacak
                    
                }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
            
        }
    }


 }

}
