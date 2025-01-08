//
//  Stage3.swift
//  game-sample
//
//  Created by 이영수 on 1/8/25.
//

import SpriteKit

struct Stage3 {
    static func setup(in scene: StageScene) {
        // Field Set
        let field = GameField(
            width: scene.size.width,
            height: scene.size.height
        )
        
        // Ground Set
        field.addPlatform(
            .ground,
            at: CGPoint(x: scene.size.width / 2, y: 25),
            size: CGSize(width: scene.size.width, height: 20)
        )
        
        // Player Set
        let player = GameCharacter(
            texture: nil,
            state: BasicCharacterState.stats
        )
        player.color = .red
        player.size = CGSize(width: 20, height: 25)
        player.position = CGPoint(x: 100, y: scene.frame.midY)
        /* TEST ( NO TEXTURE _ ADD : PHYSICS BODY ) */
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        
        // Entity Set
        let enemy = BasicGameEntity(texture: nil)
        enemy.color = .white
        enemy.size = CGSize(width: 20, height: 20)
        enemy.position = CGPoint(x: scene.size.width - 100, y: scene.frame.midY)
        /* TEST ( NO TEXTURE _ ADD : PHYSICS BODY ) */
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        
        // add scene
        scene.addChild(field)
        scene.addChild(player)
        scene.addChild(enemy)
    }
}

