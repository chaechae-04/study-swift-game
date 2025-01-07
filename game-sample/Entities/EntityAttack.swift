//
//  EntityAttack.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

class EntityAttackNode: SKSpriteNode {
    let damage: Float
    
    init(damage: Float, size: CGSize, position: CGPoint, duration: TimeInterval) {
        self.damage = damage
        super.init(
            texture: nil,
            color: .red,
            size: size
        )
        
        let fadeOut = SKAction.fadeOut(withDuration: duration)
        let remove = SKAction.removeFromParent()
        self.run(SKAction.sequence([fadeOut, remove]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
