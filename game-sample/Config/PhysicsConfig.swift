//
//  PhysicsConfig.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

struct PhysicsConfig {
    struct Categoty {
        static let none: UInt32 = 0
        static let player: UInt32 = 0x1 << 0        // 1
        static let playerAttack: UInt32 = 0x2 << 1  // 2
        static let entity: UInt32 = 0x3 << 2        // 4
        static let entityAttack: UInt32 = 0x4 << 3  // 8
        static let field: UInt32 = 0x5 << 4         // 16
    }
    
    static func playerPhysics() -> SKPhysicsBody {
        let body = SKPhysicsBody()
        body.categoryBitMask = Categoty.player
        body.collisionBitMask = Categoty.field | Categoty.entity
        body.contactTestBitMask = Categoty.entity | Categoty.entityAttack
        
        return body
    }
    
    static func entityPhysics() -> SKPhysicsBody {
        let body = SKPhysicsBody()
        body.categoryBitMask = Categoty.entity
        body.collisionBitMask = Categoty.field
        body.contactTestBitMask = Categoty.playerAttack
        
        return body
    }
}
