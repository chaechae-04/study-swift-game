//
//  JumpButton.swift
//  game-sample
//
//  Created by 이영수 on 1/5/25.
//

import SpriteKit

class JumpButton: SKSpriteNode {
    weak var player: PlayerNode?
    private var jumpForce: CGFloat = 300
    
    init(jumpForce: CGFloat) {
        super.init(
            texture: nil,
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        self.jumpForce = jumpForce
        setupJumpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupJumpButton() {
        let image = UIImage(systemName: "arrowshape.up.fill")
        texture = SKTexture(image: image ?? UIImage())
        isUserInteractionEnabled = true
        name = "jumpButton"
        alpha = 0.7
        zPosition = 10
    }
    
    private func jumpPlayer() {
        
        guard let player = player else { return }
        
        if !player.isJumping && !player.isDoubleJumping {
            player.isDoubleJumping = true
            player.isGrounded = false
            player.physicsBody?.applyImpulse(
                CGVector(
                    dx: 0,
                    dy: jumpForce
                )
            )
        } else if !player.isJumping && player.isDoubleJumping {
            player.isJumping = true
            player.physicsBody?.applyImpulse(
                CGVector(
                    dx: 0,
                    dy: jumpForce
                )
            )
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        jumpPlayer()
    }
    
}
