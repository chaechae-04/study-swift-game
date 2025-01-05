//
//  MoveButton.swift
//  game-sample
//
//  Created by 이영수 on 1/5/25.
//

import SpriteKit

class MoveButton: SKSpriteNode {
    weak var player: PlayerNode?
    //  left = -1.0
    //  right = 1.0
    private var direction: CGFloat = 1.0
    private var moveForce: CGFloat = 200
    
    public var isPressed: Bool = false
    
    init(moveForce: CGFloat, direction: CGFloat) {
        super.init(
            texture: nil,
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        self.moveForce = moveForce
        self.direction = direction
        setupMoveButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupMoveButton() {
        let image = UIImage(systemName: direction == 1.0 ? "arrowshape.right.fill" : "arrowshape.left.fill")
        texture = SKTexture(image: image ?? UIImage())
        isUserInteractionEnabled = true
        name = "moveButton"
        alpha = 0.7
        zPosition = 10
    }
    
    public func movePlayer() {
        guard isPressed else { return }
        
        player?.physicsBody?.velocity.dx = direction * moveForce
        player?.lastDirection = direction == 1.0 ? "right" : "left"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = true
        movePlayer()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = false
        
    }
}
