//
//  AtteckButton.swift
//  game-sample
//
//  Created by 이영수 on 1/6/25.
//

import SpriteKit

class AttackButton: SKSpriteNode {
    weak var player: PlayerNode?
    private var attackForce: CGFloat = 3
    private var attackCoolTime: CGFloat = 0.2
    
    init(attackForce: CGFloat, attackCoolTime: CGFloat) {
        super.init(
            texture: nil,
            color: .red,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        self.attackCoolTime = attackCoolTime
        self.attackForce = attackForce
        setupAttackButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupAttackButton() {
        let image = UIImage(systemName: "bolt.circle.fill")
        texture = SKTexture(image: image ?? UIImage())
        isUserInteractionEnabled = true
        name = "attackButton"
        alpha = 0.7
        zPosition = 10
    }
    
    private func showAttackAction() {
        
        guard !(player?.isAttackCoolTime ?? false) else { return }
        
        player?.isAttackCoolTime = true
        
        let attackText = SKLabelNode(text: "Attack !")
        attackText.position = CGPoint(
            x: player?.position.x ?? 0,
            y: (player?.position.y ?? 0) + 50
        )
        attackText.zPosition = 20
        attackText.fontSize = 20
        attackText.fontColor = .red
        
        player?.parent?.addChild(attackText)
        attackText.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 1),
            SKAction.wait(forDuration: attackCoolTime),
            SKAction.run { [weak self] in
                self?.player?.isAttackCoolTime = false
            },
            SKAction.removeFromParent()
        ]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showAttackAction()
    }
    
}
