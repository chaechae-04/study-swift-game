//
//  StageScene.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

class StageScene: SKScene {
    
    let stageNumber: Int
    
    private var pauseButton: SKSpriteNode?
    
    init(size: CGSize, stageNumber: Int) {
        self.stageNumber = stageNumber
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        setupSystemButtons()
        setupStage()
    }
    
    /* PAUSE BUTTON : padding 값 고쳐야 함 */
    private func setupSystemButtons() {
        pauseButton = SKSpriteNode(color: .gray, size: SystemButtonConfig.Pause.size)
        if let pauseButton = pauseButton {
            pauseButton.position = CGPoint(
                x: size.width - SystemButtonConfig.Pause.padding,
                y: size.height - SystemButtonConfig.Pause.padding
            )
            pauseButton.name = "pauseButton"
            addChild(pauseButton)
        }
    }
    
    private func setupStage() {
        // PhysicsWorld Set
        physicsWorld.gravity = CGVector(dx: 0, dy: GameSettings.System.gravity)
        
        switch stageNumber {
        case 1:
            Stage1.setup(in: self)
        case 2:
            Stage2.setup(in: self)
        case 3:
            Stage3.setup(in: self)
        default:
            Stage1.setup(in: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = nodes(at: location).first
        
        if touchedNode?.name == "pauseButton" {
            togglePause()
        }
    }
    
    /* PAUSE BUTTON ACTION */
    private func togglePause() {

    }
}
