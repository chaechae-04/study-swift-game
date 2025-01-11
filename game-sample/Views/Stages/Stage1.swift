//
//  Stage1.swift
//  game-sample
//
//  Created by 이영수 on 1/8/25.
//

import SpriteKit

struct Stage1 {
    static func setup(in scene: StageScene) {
        // Field Set
        let field = SKNode()
        
        // Ground Set
        let ground = PlatformNode(
            type: .ground,
            size: GameStageConfig.Size.ground
        )
        ground.position = GameStageConfig.Position.ground()
        field.addChild(ground)
        
        // Player Set
        let player = GameCharacter(
            texture: nil,
            state: BasicCharacterState.stats
        )
        player.color = .red
        player.size = GameStageConfig.Size.character
        player.position = GameStageConfig.Position.player()
        /* TEMP PHYSICS BODY */
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        
        // Entity Set
        let enemy = BasicGameEntity(texture: nil)
        enemy.color = .blue
        enemy.size = GameStageConfig.Size.entity
        enemy.position = GameStageConfig.Position.enemy()
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        
        // Add Child
        scene.addChild(field)
        scene.addChild(player)
        scene.addChild(enemy)
        
    }
}
