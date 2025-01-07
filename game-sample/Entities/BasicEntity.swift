//
//  BasicEntity.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

class BasicGameEntity: GameEntity {
    static let defaultStats = (
        hp: Float(20),
        damage: Float(1)
    )
    
    init(texture: SKTexture?) {
        super.init(
            texture: texture,
            hp: BasicGameEntity.defaultStats.hp,
            damage: BasicGameEntity.defaultStats.damage
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
