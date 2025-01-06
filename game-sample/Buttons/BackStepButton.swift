//
//  BackStepButton.swift
//  game-sample
//
//  Created by 이영수 on 1/5/25.
//

import SpriteKit

class BackStepButton: SKSpriteNode {
    
    weak var player: PlayerNode?
    var backStepForce: CGFloat = 300
    var backStepDuration: CGFloat = 0.2
    var backStepCoolTime: CGFloat = 2.0
    
    let imageName: String = "chevron.right.2"
    
    init(backStepForce: CGFloat, backStepCoolTime: CGFloat, backStepDuration: CGFloat) {
        super.init(
            texture: nil,
            color: .clear,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        self.backStepForce = backStepForce
        self.backStepCoolTime = backStepCoolTime
        self.backStepDuration = backStepDuration
        setupBackStepButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupBackStepButton() {
        let image = UIImage(systemName: imageName)
        texture = SKTexture(image: image ?? UIImage())
        isUserInteractionEnabled = true
        name = "backStepButton"
        alpha = 0.7
        zPosition = 10
    }
    
    private func backStepPlayer() {
        guard let player = player, !player.isBackStepCoolTime else { return }
        
        let direction: CGFloat = player.lastDirection == "right" ? -1.0 : 1.0
        let totalDistance: CGFloat = player.isDoubleJumping ? direction * (backStepForce + 300) : direction * backStepForce
        
        player.isBackSteping = true
        
        
        player.run(SKAction.sequence([
            SKAction.run { [weak self] in
                self?.player?.isBackSteping = true
            },
            SKAction.applyImpulse(
                CGVector(
                    dx: totalDistance,
                    dy: 200
                ),
                duration: backStepDuration * 0.4
            ),
            SKAction.applyImpulse(
                CGVector(
                    dx: (-totalDistance) * 0.3,
                    dy: 0
                ),
                duration: backStepDuration * 0.2
            ),
            SKAction.wait(forDuration: backStepDuration * 0.4),
            SKAction.run { [weak self] in
                self?.player?.isBackSteping = false
            },
        ]))
        
        startCoolTime()
    }
    
    private func startCoolTime() {
        player?.isBackStepCoolTime = true
        player?.color = .orange
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: backStepCoolTime),
            SKAction.run { [weak self] in
                self?.player?.isBackStepCoolTime = false
                self?.player?.color = .red
            }
        ]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        backStepPlayer()
    }
}
