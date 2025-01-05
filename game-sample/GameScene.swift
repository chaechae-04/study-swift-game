//
//  GameScene.swift
//  game-sample
//
//  Created by 이영수 on 1/4/25.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /* CONTENTS */
    private var player: PlayerNode!
    private var field: BasicField!
    
    /* BUTTONS */
    private var leftButton: MoveButton!
    private var rightButton: MoveButton!
    private var jumpButton: JumpButton!
    private var backStepButton: BackStepButton!
    
    /* SPEC START */
    private var hp: CGFloat!
    
    /* ACTIONS FORCE */
    private var moveForce: CGFloat!
    private var jumpForce: CGFloat!
    private var backStepForce: CGFloat!
    
    /* ACTIONS DURATION */
    private var backStepDuration: CGFloat!
    
    /* ACTIONS COOLTIME */
    private var backStepCoolTime: CGFloat!
    /* SPEC END */
    
    /* CONTENT CATEGORY */
    public static let playerCategory: UInt32 = 0x1 << 0
    public static let groundCategory: UInt32 = 0x1 << 1
    
    /* START */
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        setupGame()
        
    }
    
    /* UPDATE */
    override func update(_ currentTime: TimeInterval) {
        
        /* move */
        [leftButton, rightButton].forEach { button in
            
            if button.isPressed {
                button.movePlayer()
            } else if let player = button.player, !player.isGrounded {
                player.physicsBody?.velocity.dx *= 0.95
            }
            
        }
    }
    
    /* COLLISION DETECTION */
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask |
                        contact.bodyB.categoryBitMask
        
        if collision == (GameScene.playerCategory | GameScene.groundCategory) {
            
            player.isGrounded = true
            player.isJumping = false
            player.isDoubleJumping = false
        }
    }
    
    /* USERE FUNCTIONS */
    /* SET UP */
    private func setupGame() {
        
        /* PLAYER SET START */
        player = PlayerNode(
            size: CGSize(
                width: 30,
                height: 30
            )
        )
        player.position = CGPoint(
            x: frame.midX,
            y: frame.midY
        )
        
        /* PLAYER SPEC SET */
        hp = player.hp
        moveForce = player.moveForce
        jumpForce = player.jumpForce
        backStepForce = player.backStepForce
        backStepDuration = player.backStepDuration
        backStepCoolTime = player.backStepCoolTime
        /* PLAYER SET END */
        
        /* BUTTON SET (MOVE) */
        leftButton = MoveButton(moveForce: moveForce, direction: -1.0)
        leftButton.player = player
        leftButton.position = CGPoint(
            x: 80,
            y: 100
        )
        
        rightButton = MoveButton(moveForce: moveForce, direction: 1.0)
        rightButton.player = player
        rightButton.position = CGPoint(
            x: 160,
            y: 100
        )
        
        /* BUTTON SET (JUMP) */
        jumpButton = JumpButton(jumpForce: jumpForce)
        jumpButton.player = player
        jumpButton.position = CGPoint(
            x: frame.width - 160,
            y: 100
        )
        
        /* BUTTON SET (BACKSTEP) */
        backStepButton = BackStepButton(backStepForce: backStepForce, backStepCoolTime: backStepCoolTime,backStepDuration: backStepDuration)
        backStepButton.player = player
        backStepButton.position = CGPoint(
            x: frame.width - 80,
            y: 100
        )
        backStepButton.zPosition = 10
        
        /* FIELD SET */
        field = BasicField(size: self.size)
        
        /* ADDCHILD */
        addChild(player)
        
        addChild(leftButton)
        addChild(rightButton)
        addChild(jumpButton)
        addChild(backStepButton)
        
        addChild(field)
        
    }
}
