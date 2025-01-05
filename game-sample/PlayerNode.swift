//
//  Player.swift
//  game-sample
//
//  Created by 이영수 on 1/5/25.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    private var leftArrow: SKSpriteNode!
    private var rightArrow: SKSpriteNode!
    
    var lastDirection: String = "right"
    
    var isJumping: Bool = false
    var isGrounded: Bool = false
    var isDoubleJumping: Bool = false
    
    var isBackStepCoolTime: Bool = false
    
    /* CHARACTER SPEC */
    var hp: CGFloat = 5
    
    var moveForce: CGFloat = 225
    var jumpForce: CGFloat = 300
    var backStepForce: CGFloat = 300
    var backStepDuration: CGFloat = 0.2
    var backStepCoolTime: CGFloat = 2.0
    /* CHARACTER SPEC */
    
    init(size: CGSize) {
        super.init(
            texture: nil,
            color: .red,
            size: size
        )
        setupPlayer()
        setupArrows()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(
            coder: aDecoder
        )
    }
    
    private func setupPlayer() {
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0.5
        self.physicsBody?.linearDamping = 0.5
        self.physicsBody?.restitution = 0
        self.physicsBody?.collisionBitMask = GameScene.groundCategory
        self.physicsBody?.contactTestBitMask = GameScene.groundCategory
        self.physicsBody?.categoryBitMask = GameScene.playerCategory
        self.physicsBody?.friction = 0.5
    }
    
    private func setupArrows() {
        if let leftImage = UIImage(systemName: "chevron.left"),
           let rightImage = UIImage(systemName: "chevron.right") {
            leftArrow = SKSpriteNode(
                texture: SKTexture(
                    image: leftImage
                )
            )
            rightArrow = SKSpriteNode(
                texture: SKTexture(
                    image: rightImage
                )
            )
            
            leftArrow.alpha = 0
            rightArrow.alpha = 0
            
            addChild(leftArrow)
            addChild(rightArrow)
        }
    }
    
    func updateArrowPositions() {
        leftArrow.position = CGPoint(
            x: -40,
            y: 0
        )
        rightArrow.position = CGPoint(
            x: 40,
            y: 0
        )
    }
}
