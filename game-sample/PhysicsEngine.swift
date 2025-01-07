//
//  PhysicsEngine.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

class PhysicsSetup {
    static func setupCharacterPhysics(for sprite: SKSpriteNode) {
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        sprite.physicsBody?.isDynamic = true
        sprite.physicsBody?.allowsRotation = false
        sprite.physicsBody?.restitution = 0.0
    }
    
    static func setupPlatformPhysics(for sprite: SKSpriteNode) {
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        sprite.physicsBody?.isDynamic = false
        sprite.physicsBody?.friction = 0.2
    }
}
