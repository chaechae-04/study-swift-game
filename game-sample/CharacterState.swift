//
//  CharacterState.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

protocol CharacterStateProtocol {
    var hp: Float { get set }
    var mp: Float { get set }
    
    var attackDamage: Float { get set }
    var attackSpeed: Float { get set }
    var attackRange: CGFloat { get set }
    
    var moveSpeed: CGFloat { get set }
    var jumpForce: CGFloat { get set }
    
    var backStepForce: CGFloat { get set }
    var backDashCoolTime: TimeInterval { get set }
}

struct CharacterState: CharacterStateProtocol {
    var hp: Float
    var mp: Float
    
    var attackDamage: Float
    var attackSpeed: Float
    var attackRange: CGFloat
    
    var moveSpeed: CGFloat
    var jumpForce: CGFloat
    
    var backStepForce: CGFloat
    var backDashCoolTime: TimeInterval
}

class GameCharacter: SKSpriteNode {
    private var state: CharacterStateProtocol
    
    init(texture: SKTexture?, state: CharacterState) {
        self.state = state
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
