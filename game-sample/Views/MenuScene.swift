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
        // 화면 크기 및 비율 설정
        self.size = CGSize(
            width: GameSettings.Screen.width,
            height: GameSettings.Screen.height
        )
        self.scaleMode = .aspectFit
        
        let titleLabel = SKLabelNode(text: MenuButtonConfig.Text.title)
        titleLabel.fontSize = MenuButtonConfig.Style.fontSize * 1.5 * GameSettings.Screen.scaleRatio
        titleLabel.position = CGPoint(
            x: frame.midX,
            y: frame.maxY + MenuButtonConfig.Position.titleY * GameSettings.Screen.scaleRatio
        )
        addChild(titleLabel)
        
        // 스테이지 선택 버튼
        MenuButtonConfig.Text.stages.enumerated().forEach { index,stageName in
            let button = createStageButton(stageName, at: index)
            addChild(button)
        }
    }
    
    private func createStageButton(_ title: String, at index: Int) -> SKNode {
        let buttonSize = CGSize(
            width: MenuButtonConfig.size.width * GameSettings.Screen.scaleRatio,
            height: MenuButtonConfig.size.height * GameSettings.Screen.scaleRatio
        )
        
        let button = SKShapeNode(rectOf: buttonSize)
        button.fillColor = MenuButtonConfig.Style.fillColor
        button.strokeColor = MenuButtonConfig.Style.strokeColor
        button.position = CGPoint(
            x: frame.midX,
            y: frame.midY + MenuButtonConfig.Position.firstButtonY - (MenuButtonConfig.spacing * CGFloat(index)) * GameSettings.Screen.scaleRatio
        )
        
        let label = SKLabelNode(text: title)
        label.fontSize = MenuButtonConfig.Style.fontSize * GameSettings.Screen.scaleRatio
        label.position = CGPoint(x: 0, y: -7 * GameSettings.Screen.scaleRatio)
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
