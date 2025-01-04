//
//  GameScene.swift
//  game-sample
//
//  Created by 이영수 on 1/4/25.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var player: SKSpriteNode!
    private var ground: SKSpriteNode!
    private var walls: [CGRect]!
    private var leftButton: SKSpriteNode!
    private var rightButton: SKSpriteNode!
    private var jumpButton: SKSpriteNode!
    private var backStepButton: SKSpriteNode!
    
    private var touchStartButton: SKNode?
    
    private var isMovingLeft: Bool = false
    private var isMovingRight: Bool = false
    private var isJumping: Bool = false
    private var isBackSteping: Bool = false
    
    private var lastDirection: String = "right"
    
    private var moveForce: CGFloat = 200
    private var jumpForce: CGFloat = 500
    private var backStepForce: CGFloat = 400
    
    private var backStepDuration: Double = 0.2
    
    private var canbackStep: Bool = true
    private var backStepCoolTime: Double = 0.5
    private var isGrounded: Bool = true
    
    // 충돌 카테고리
    let playerCategory: UInt32 = 0x1 << 0
    let groundCategory: UInt32 = 0x1 << 1
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        setupGame()
        
    }
    
    /* SET UP */
    
    func setupGame() {
        setupPlayer()
        setupButton()
        setupGround()
        setupWall()
        setupCollision()
    }
    
    func setupPlayer() {
        player = SKSpriteNode(
            color: .red,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.mass = 0.5
        player.physicsBody?.linearDamping = 0.5
        player.physicsBody?.restitution = 0
        player.physicsBody?.categoryBitMask = playerCategory
        addChild(player)
    }
    
    func setupButton() {
        leftButton = SKSpriteNode(
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        leftButton.position = CGPoint(x: 50, y: 100)
        leftButton.name = "leftButton"
        leftButton.alpha = 0.7
        addChild(leftButton)
        
        rightButton = SKSpriteNode(
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        rightButton.position = CGPoint(x: 120, y: 100)
        rightButton.name = "rightButton"
        rightButton.alpha = 0.7
        addChild(rightButton)
        
        backStepButton = SKSpriteNode(
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        backStepButton.position = CGPoint(x: frame.width - 70, y: 100)
        backStepButton.name = "backStepButton"
        backStepButton.alpha = 0.7
        addChild(backStepButton)
        
        jumpButton = SKSpriteNode(
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        jumpButton.position = CGPoint(x: frame.width - 130, y: 100)
        jumpButton.name = "jumpButton"
        jumpButton.alpha = 0.7
        addChild(jumpButton)
    }
    
    func setupGround() {
        ground = SKSpriteNode(
            color: .green,
            size: CGSize(
                width: frame.width,
                height: 20
            )
        )
        ground.position = CGPoint(x: frame.midX, y: 20)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = groundCategory
        addChild(ground)
    }
    
    func setupWall() {
        walls = [
            // left wall
            CGRect(
                x: 0,
                y: 0,
                width: 1,
                height: frame.height
            ),
            // right wall
            CGRect(
                x: frame.width - 1,
                y: 0,
                width: 1,
                height: frame.height
            )
        ]
        for wall in walls {
            let barrier = SKSpriteNode(
                color: .clear,
                size: wall.size
            )
            barrier.position = CGPoint(
                x: wall.minX,
                y: wall.midY
            )
            barrier.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
            barrier.physicsBody?.isDynamic = false
            barrier.alpha = 0
            addChild(barrier)
        }
    }
    
    func setupCollision() {
        player.physicsBody?.contactTestBitMask = groundCategory
    }
    
    /* ACTION */
    
    func performJume() {
        if !isJumping {
            isJumping = true
            isGrounded = false
            player.physicsBody?.applyImpulse(CGVector(
                dx: 0,
                dy: jumpForce
                )
            )
        }
    }
    
    func performbackStep() {
        guard canbackStep && !isBackSteping else { return }
        
        isBackSteping = true
        canbackStep = false
        
        let backStepDirection: CGFloat = lastDirection == "right" ? -1 : 1
        let isAirborne: Bool = !isGrounded
        
        if !isAirborne {
            player.physicsBody?.velocity = .zero
        }
        
        // 처음
        applyBackStepForce(multiplier: 0.9, direction: backStepDirection)
        // 마무리
        Timer.scheduledTimer(withTimeInterval: backStepDuration * 0.9,
                             repeats: false) { _ in
            self.applyBackStepForce(multiplier: 0.1, direction: backStepDirection)
            
            Timer.scheduledTimer(withTimeInterval: self.backStepDuration * 0.1,
                                 repeats: false) { _ in
                self.finishBackStep(isAirborne: isAirborne)
            }
        }
        
    }
    
    private func applyBackStepForce(multiplier: CGFloat, direction: CGFloat) {
        player.physicsBody?.applyImpulse(
            CGVector(
                dx: backStepForce * multiplier * direction,
                dy: 110
            )
        )
    }
    
    private func finishBackStep(isAirborne: Bool) {
        isBackSteping = false
        
        if !isAirborne {
            player.physicsBody?.velocity.dx = 0
        }
        
        Timer.scheduledTimer(withTimeInterval: backStepCoolTime,
                             repeats: false) { _ in
            self.canbackStep = true
        }
    }
    
    func checkGrounded() {
        let rayLength: CGFloat = 2.0
        
        guard player.physicsBody != nil else { return }
        
        
        let rayStart = CGPoint(
            x: player.position.x,
            y: player.position.y - player.size.height / 2
        )
        let rayEnd = CGPoint(
            x: rayStart.x,
            y: rayStart.y - rayLength
        )
        
        scene?.physicsWorld.enumerateBodies(alongRayStart: rayStart, end: rayEnd) { body, point, normal, stop in
            if body.node?.name == "ground" {
                self.isGrounded = true
                stop.pointee = true
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if isBackSteping { return }
        
        if isMovingLeft {
            player.physicsBody?.velocity = CGVector(
                dx: -moveForce,
                dy: player.physicsBody?.velocity.dy ?? 0
            )
        } else if isMovingRight {
            player.physicsBody?.velocity = CGVector(
                dx: moveForce,
                dy: player.physicsBody?.velocity.dy ?? 0
            )
        } else {
            
            if isGrounded {
                player.physicsBody?.velocity = CGVector(
                    dx: player.physicsBody?.velocity.dx ?? 0 * 0.98,
                    dy: player.physicsBody?.velocity.dy ?? 0
                )
            } else {
                player.physicsBody?.velocity.dx = player.physicsBody?.velocity.dx ?? 0 * 0.98
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if let node = nodes(at: location).first {
                
                touchStartButton = node
                
                switch node.name {
                    
                case "leftButton":
                    isMovingLeft = true
                    lastDirection = "left"
                    
                case "rightButton":
                    isMovingRight = true
                    lastDirection = "right"
                    
                case "jumpButton":
                    performJume()
                    
                case "backStepButton":
                    performbackStep()
                    
                default:
                    break
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            let node = nodes(at: location).first
            
            if node?.name == "leftButton" {
                isMovingLeft = false
            } else if node?.name == "rightButton" {
                isMovingRight = false
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if let startButton = touchStartButton {
                if !startButton.contains(location) {
                    switch startButton.name {
                    case "leftButton":
                        isMovingLeft = false
                    case "rightButton":
                        isMovingRight = false
                    default:
                        break
                    }
                }
            }
            
            if let node = nodes(at: location).first {
                if node.name == "leftButton" {
                    isMovingLeft = true
                    isMovingRight = false
                } else if node.name == "rightButton" {
                    isMovingLeft = false
                    isMovingRight = true
                }
            }
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == groundCategory ||
            contact.bodyB.categoryBitMask == groundCategory {
            isJumping = false
            isGrounded = true
        }
    }
}
