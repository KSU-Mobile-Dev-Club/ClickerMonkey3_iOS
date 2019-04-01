//
//  ViewController.swift
//  ClickerMonkey3
//
//  Created by Steven Blair on 3/20/19.
//  Copyright © 2019 Steven Blair. All rights reserved.
//
import SpriteKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let view = self.view as! SKView? {
            // Load the SKScene
            
            
            //an SKView has a scene below it, just like how a viewcontroller has a view, here we are just creating an SKscene that will be used below it
            if let scene = SKScene(fileNamed: "Monkey.sks") {
                
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                
                
                // Present the scene
                view.presentScene(scene)
            }
            
            //self explainitory
            view.isMultipleTouchEnabled = true
            
            //not to sure on this one
            view.ignoresSiblingOrder = true
            
            //self explainatory
            view.showsFPS = true
            
            //this tells the node count of the view, nodes are the highest class order of things you  can put into an SKView, In our case, we used SKSpriteNodes
            view.showsNodeCount = true
        }
    }
    }




