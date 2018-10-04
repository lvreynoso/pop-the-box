//
//  TinyLabel.swift
//  Pop the Box
//
//  Created by Lucia Reynoso on 9/27/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TinyLabel: SKLabelNode {
    
    init(score: Int) {
        super.init()
        self.fontName = "AmericanTypewriter-Bold"
        self.text = "\(score)!"
        self.fontColor = .white
        self.fontSize = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func floatUp() {
        let moveUp = SKAction.moveBy(x: 0, y: 50, duration: 1)
        self.run(moveUp) {
            self.removeFromParent()
        }
    }
    
}
