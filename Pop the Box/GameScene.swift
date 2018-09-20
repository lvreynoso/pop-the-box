//
//  GameScene.swift
//  Pop the Box
//
//  Created by Lucia Reynoso on 9/20/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let squareSize = CGSize(width: 40, height: 40)
    var score: Int = 0
    var scoreLabel = SKLabelNode(fontNamed: "Helvetica")
    var counter: Int = 0
    enum GameState {
        case run, gameOver
    }
    var state: GameState = .run
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        
        scoreLabel.text = "Score: \(score)"
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height - 35)
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 30
        
        addChild(scoreLabel)
    }
    
    func makeBox() {
        let color = UIColor(hue: CGFloat.random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
        let box = SKSpriteNode(texture: nil, color: color, size: squareSize)
        box.name = "box"
        let xPosition = Int.random(in: 20...Int(self.size.width - 20))
        box.position = CGPoint(x: xPosition, y: 0)
        addChild(box)
        
        // zoom!
        let moveUp = SKAction.moveTo(y: size.height, duration: Double(Int.random(in: 1...6)))
        let seq = SKAction.sequence([moveUp, .removeFromParent()])
        box.run(seq) {
            self.score -= 1
            self.updateLabel()
        }
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
                    touchedNode.removeFromParent()
                    score += 1
                    updateLabel()
                }
            }
        }
    }
    
    func updateLabel() {
        if score < 0 {
            gameOver()
        } else {
            scoreLabel.text = "Score: \(score)"
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
    
    override func update(_ currentTime: TimeInterval) {
        if state != .run { return }
        if counter <= 0 {
            makeBox()
            counter = 15 * Int.random(in: 1...4)
        } else {
            counter -= 1
        }
    }
}
