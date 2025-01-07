//
//  StageScene.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

class StageScene: SKScene {
    let stageNumber: Int
    
    init(size: CGSize, stageNumber: Int) {
        self.stageNumber = stageNumber
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        setupStage()
    }
    
    private func setupStage() {
        // 스테이지 설정
        let field = GameField(width: size.width, height: size.height)
        
        field.addPlatform(
            .ground,
            at: CGPoint(x: size.width / 2, y: 25),
            size: CGSize(width: size.width, height: 20)
        )
        
        // 플레이어 설정
        let player = GameCharacter(
            texture: nil,
            state: BasicCharacterState.stats
        )
        
        player.color = .red
        player.size = CGSize(width: 30, height: 30)
        player.position = CGPoint(x: 100, y: 50)
        
        // 엔티티 설정
        let enemy = BasicGameEntity(texture: nil)
        enemy.color = .blue
        enemy.size = CGSize(width: 30, height: 30)
        enemy.position = CGPoint(x: size.width - 100, y: 50)
        
        addChild(field)
        addChild(player)
        addChild(enemy)
        
    }
}
