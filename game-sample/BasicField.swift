//
//  BasicField.swift
//  game-sample
//
//  Created by 이영수 on 1/5/25.
//

import SpriteKit

class BasicField: SKSpriteNode {
    private var ground: SKSpriteNode!
    private var walls: [SKSpriteNode] = []
    
    init(size: CGSize) {
        super.init(
            texture: nil,
            color: .clear,
            size: size
        )
        setupGround()
        setupWalls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupGround() {
        ground = SKSpriteNode(
            color: .green,
            size: CGSize(
                width: size.width,
                height: 20
            )
        )
        ground.position = CGPoint(
            x: size.width / 2,
            y: 20
        )
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.contactTestBitMask = GameScene.playerCategory
        ground.physicsBody?.categoryBitMask = GameScene.groundCategory
        ground.physicsBody?.friction = 0.5
        ground.zPosition = 1
        
        addChild(ground)
    }
    
    private func setupWalls() {
        let wallRects = [
            CGRect(
                x: 0,
                y: 0,
                width: 1,
                height: size.height
            ),
            CGRect(
                x: size.width - 1,
                y: 0,
                width: 1,
                height: size.height
            )
        ]
        
        for rect in wallRects {
            let wall = SKSpriteNode(
                color: .clear, 
                size: rect.size
            )
            
            wall.position = CGPoint(
                x: rect.minX,
                y: rect.midY
            )
            wall.physicsBody = SKPhysicsBody(rectangleOf: rect.size)
            wall.physicsBody?.isDynamic = false
            wall.zPosition = 1
            walls.append(wall)
            addChild(wall)
        }   
    }
}
