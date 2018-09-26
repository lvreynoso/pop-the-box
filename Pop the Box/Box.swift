//
//  Box.swift
//  Pop the Box
//
//  Created by Lucia Reynoso on 9/25/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Box: SKSpriteNode {
    
    init(squareSize: CGSize, color: UIColor, name: String, screenSize: CGSize) {
        super.init(texture: nil, color: color, size: squareSize)
        self.name = name
        setup(width: screenSize.width)
    }
    
    func setup(width: CGFloat) {
        let xPosition = Int.random(in: 20...Int(width - 20))
        self.position = CGPoint(x: xPosition, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
