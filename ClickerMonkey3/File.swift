//
//  File.swift
//  ClickerMonkey3
//
//  Created by caden on 3/27/19.
//  Copyright © 2019 Steven Blair. All rights reserved.
//

import Foundation
import SpriteKit
import Firebase


class scene: SKScene {
    var count = 0
    var monkey = SKSpriteNode()
    var timerLabel = SKLabelNode()
    var time = 0.0
    var relativeTime = 0.0
    var animationTime = 0.0
    var start = false
    var started = false
    var retry = SKLabelNode()
    var retryBack = SKSpriteNode()
    var x = SKLabelNode()
    
    override func didMove(to view: SKView) {
        timerLabel = self.childNode(withName: "timerLabel") as! SKLabelNode
        monkey = self.childNode(withName: "monkey") as! SKSpriteNode
        timerLabel.text = "Time: \(0)"
        retry = self.childNode(withName: "retry") as! SKLabelNode
        retryBack = self.childNode(withName: "retryBack") as! SKSpriteNode
        retryBack.alpha = 0
        retry.alpha = 0
        x = self.childNode(withName: "count") as! SKLabelNode
        x.text = "Click me!"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            if monkey.contains(touch.location(in: self)) && retryBack.alpha == 0 {
                start = true
            }
            
            if start {
                if !started {
                    relativeTime = time
                    started = true
                    x.text = "Count \(0)"
                }
            
            if monkey.contains(touch.location(in: self)) {
                
                count += 1
                x.text = "Count \(count)"
                if count % 2 == 0 {
                monkey.texture = SKTexture(imageNamed: "monkeyflip.png")
                }
                else {
                    monkey.texture = SKTexture(imageNamed: "monkey.png")

                }
            }
        }
            
            if retryBack.contains(touch.location(in: self)) {
                retryBack.alpha = 0
                retry.alpha = 0
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if started {
            timerLabel.text = "Time: \(30 - round(10 * (time - relativeTime)) / 10)"

        }
        if currentTime - animationTime > 0.5 {
            monkey.run(.rotate(byAngle: 3.14 / 600, duration: 0))
            
        }
        if time - relativeTime >= 30 && started {
            start = false
            started = false
            retryBack.alpha = 1
            retry.alpha = 1
            // send score to leaderboard
            recordScore()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // do stuff 42 seconds later
            }
        }
        time = currentTime
    }
    
    
    func recordScore() {
        // prompt the user for their name
        let prompt = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert)
        
        prompt.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your name here..."
        })
        
        prompt.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = prompt.textFields?.first?.text {
                print("Your name: \(name)")
                self.uploadScore(of: name, with: self.count)
            }
            self.count = 0
        }))
        
        // show the alert
        self.view?.window?.rootViewController?.present(prompt, animated: true, completion: nil)
    }
    
    func uploadScore(of player : String, with score : Int) {
        print(score)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("scores").child(player).setValue(score)
    }
}
