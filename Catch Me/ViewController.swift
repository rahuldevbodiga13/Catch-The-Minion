//
//  ViewController.swift
//  Catch Me
//
//  Created by Rahul Dev on 23/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var minion1: UIImageView!
    
    @IBOutlet weak var minion2: UIImageView!
    
    @IBOutlet weak var minion3: UIImageView!
    
    @IBOutlet weak var minion4: UIImageView!
    
    @IBOutlet weak var minion5: UIImageView!
    
    @IBOutlet weak var minion6: UIImageView!
    
    @IBOutlet weak var minion7: UIImageView!
    
    @IBOutlet weak var minion8: UIImageView!
    
    @IBOutlet weak var minion9: UIImageView!
    
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var userScore: UILabel!
    
    @IBOutlet weak var highScore: UILabel!
    
    var score = 0
    var gameTimer = Timer()
    var countdown = 0
    var minionArray = [UIImageView]()
    var animatedTimer = Timer()
    let USER_SCORE = "user_score"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let storedHighScore = UserDefaults.standard.object(forKey: USER_SCORE) as? Int {
            highScore.text = String(storedHighScore)
        } else {
            highScore.text = String(0)
        }
        
        addGestures()
        initMinionArray()
        animateTheMinion()
        initiateResources()
    }
    
    func initMinionArray(){
        minionArray.append(minion1)
        minionArray.append(minion2)
        minionArray.append(minion3)
        minionArray.append(minion4)
        minionArray.append(minion5)
        minionArray.append(minion6)
        minionArray.append(minion7)
        minionArray.append(minion8)
        minionArray.append(minion9)
    }
    
    func addGestures() {
        minion1.isUserInteractionEnabled = true
        minion2.isUserInteractionEnabled = true
        minion3.isUserInteractionEnabled = true
        minion4.isUserInteractionEnabled = true
        minion5.isUserInteractionEnabled = true
        minion6.isUserInteractionEnabled = true
        minion7.isUserInteractionEnabled = true
        minion8.isUserInteractionEnabled = true
        minion9.isUserInteractionEnabled = true
        
        minion1.addGestureRecognizer(getTapRecognizer())
        minion2.addGestureRecognizer(getTapRecognizer())
        minion3.addGestureRecognizer(getTapRecognizer())
        minion4.addGestureRecognizer(getTapRecognizer())
        minion5.addGestureRecognizer(getTapRecognizer())
        minion6.addGestureRecognizer(getTapRecognizer())
        minion7.addGestureRecognizer(getTapRecognizer())
        minion8.addGestureRecognizer(getTapRecognizer())
        minion9.addGestureRecognizer(getTapRecognizer())
    }
    
    @objc func onImageTap() {
        score += 1
        userScore.text = "Your score is: \(score)"
    }
    
    func getTapRecognizer() -> UITapGestureRecognizer{
        return UITapGestureRecognizer(target: self, action: #selector(ViewController.onImageTap))
    }
    
    @objc func onEveryInterval(){
        timer.text = "Ends in : \(countdown)"
        countdown -= 1
        
        if countdown == 0 {
            
            if self.score > UserDefaults.standard.integer(forKey: USER_SCORE){
                UserDefaults.standard.set(self.score, forKey: USER_SCORE)
                highScore.text = String(self.score)
            }
            
            showAlert()
            timer.text = "Ends in : \(countdown)"
            animatedTimer.invalidate()
            gameTimer.invalidate()
        }
        
    }
    
    func showAlert(){
        let gameFinishedAlert = UIAlertController(title: "Game Finished", message: "Time is up", preferredStyle: UIAlertController.Style.alert)
        let okay = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil)
        let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
            self.initiateResources()
        }
        gameFinishedAlert.addAction(okay)
        gameFinishedAlert.addAction(replay)
        self.present(gameFinishedAlert, animated: true, completion: nil)
    }
    
    @objc func animateTheMinion(){
        for minion in minionArray {
            minion.isHidden = true
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(minionArray.count - 1)))
        
        minionArray[randomIndex].isHidden = false
        
    }
    
    func initiateResources(){
        countdown = 30
        score = 0
        userScore.text = "Your score is: \(score)"
        timer.text = "Ends in : \(countdown)"
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.onEveryInterval), userInfo: nil, repeats: true)
        animatedTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(ViewController.animateTheMinion), userInfo: nil, repeats: true)
        
    }
    
    
}

