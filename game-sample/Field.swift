//
//  Field.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

class GameField: SKNode {
    var size: CGSize
    var platforms: [PlatformNode]
    
    init(width: CGFloat, height: CGFloat) {
        self.size = CGSize(width: width, height: height)
        self.platforms = []
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPlatform(_ type: PlatformType, at position: CGPoint, size: CGSize) {
        let platform = PlatformNode(type: type, size: size)
        platform.position = position
        platforms.append(platform)
        addChild(platform)
    }
}

class PlatformNode: SKSpriteNode {
    let type: PlatformType
    
    init(type: PlatformType, size: CGSize) {
        self.type = type
        super.init(
            texture: nil,
            color: .green,
            size: size
        )
        PhysicsSetup.setupPlatformPhysics(for: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum PlatformType {
    case ground
    case wall
    case floating
}
