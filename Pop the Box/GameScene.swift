//
//  GameScene.swift
//  Pop the Box
//
//  Created by Lucia Reynoso on 9/20/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let squareSize = CGSize(width: 40, height: 40)
    let scoreLabel = ScoreLabel(font: "Helvetica", fontColor: .white, fontSize: 30)
    var counter: Int = 0
    enum GameState {
        case run, gameOver
    }
    var state: GameState = .run
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        
        // position score label, add it to the scene
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height - 35)
        addChild(scoreLabel)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if state == .run {
            // check loss condition
            if scoreLabel.actualScore < 0 {
                gameOver()
            }
            
            // check if we need to make a box
            if counter <= 0 {
                makeBox()
                counter = 15 * Int.random(in: 1...4)
            } else {
                counter -= 1
            }
        }
        scoreLabel.updateDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == .gameOver {
            if let view = self.view {
                state = .run
                // Load the SKScene from 'GameScene.sks'
                let scene = GameScene(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                view.ignoresSiblingOrder = true
                
                view.showsFPS = true
                view.showsNodeCount = true
            }
        }
        if state == .run {
            if let touch = touches.first {
                let touchedNode = self.atPoint(touch.location(in: self))
                if touchedNode.name == "box" {
                    // remove the box from the screen and give the player some points
                    touchedNode.removeFromParent()
                    scoreLabel.updateScore(score: 100)
                    
                    // pop up a little score label to show how many points the box was worth
                    let tinyLabel = TinyLabel(score: 100)
                    tinyLabel.position = touch.location(in: self)
                    addChild(tinyLabel)
                    tinyLabel.floatUp()
                }
            }
        }
    }
    
    func makeBox() {
        // create random color and starting position
        let color = UIColor(hue: CGFloat.random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
        
        // make a new box
        let box = Box(squareSize: squareSize, color: color, name: "box", screenSize: self.size)
        
        // add the box to the screen
        addChild(box)
        
        // zoom!
        zoom(box)
    }
    
    func zoom(_ node: SKSpriteNode) {
        let moveUp = SKAction.moveTo(y: self.size.height, duration: Double(Int.random(in: 1...6)))
        let seq = SKAction.sequence([moveUp, .removeFromParent()])
        node.run(seq) {
            // this only runs if the SKAction sequence is allowed to finish. if it is interrupted
            // by something, like the node being removed by a player touch, it won't run. so
            // the player can only lose points if the box makes it to the top of the screen and disappears.
            self.scoreLabel.updateScore(score: -100)
        }
    }
    
    func gameOver() {
        state = .gameOver
        self.removeAllChildren()
        let gameOverLabel = SKLabelNode(fontNamed: "Helvetica")
        gameOverLabel.text = "Game Over!"
        gameOverLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        gameOverLabel.fontColor = .white
        gameOverLabel.fontSize = 45
        
        addChild(gameOverLabel)
    }
}
