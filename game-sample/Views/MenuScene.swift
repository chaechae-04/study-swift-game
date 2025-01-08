//
//  MenuScene.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
        setupMenu()
    }
    
    private func setupMenu() {
        let titleLabel = SKLabelNode(text: MenuButtonConfig.Text.title)
        titleLabel.fontSize = MenuButtonConfig.Style.fontSize * 1.5
        titleLabel.position = CGPoint(
            x: frame.midX,
            y: frame.maxY + MenuButtonConfig.Position.titleY
        )
        addChild(titleLabel)
        
        // 스테이지 선택 버튼
        MenuButtonConfig.Text.stages.enumerated().forEach { index,stageName in
            let button = createStageButton(stageName, at: index)
            addChild(button)
        }
    }
    
    private func createStageButton(_ title: String, at index: Int) -> SKNode {
        let button = SKShapeNode(rectOf: MenuButtonConfig.size)
        button.fillColor = MenuButtonConfig.Style.fillColor
        button.strokeColor = MenuButtonConfig.Style.strokeColor
        button.position = CGPoint(
            x: frame.midX,
            y: frame.midY + MenuButtonConfig.Position.firstButtonY - (MenuButtonConfig.spacing * CGFloat(index))
        )
        
        let label = SKLabelNode(text: title)
        label.fontSize = MenuButtonConfig.Style.fontSize
        label.position = CGPoint(x: 0, y: -7)
        button.addChild(label)
        
        button.name = title
        return button
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        for node in touchedNodes {
            if let stageName = node.name,
               let stageIndex = MenuButtonConfig.Text.stages.firstIndex(of: stageName) {
                let stageNumber = stageIndex + 1
                let stageScene = SceneManager.loadScene(.stage(number: stageNumber), size: size)
                view?.presentScene(stageScene)
                break
            }
        }
    }
}
