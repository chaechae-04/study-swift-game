//
//  Entity.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

protocol EntityProtocol {
    var hp: Float { get set }
    var damage: Float { get set }
}

class GameEntity: SKSpriteNode, EntityProtocol {
    var hp: Float
    var damage: Float
    
    init(texture: SKTexture?, hp: Float, damage: Float) {
        self.hp = hp
        self.damage = damage
        super.init(
            texture: texture,
            color: .clear,
            size: texture?.size() ?? .zero
        )
        
        PhysicsSetup.setupCharacterPhysics(for: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
