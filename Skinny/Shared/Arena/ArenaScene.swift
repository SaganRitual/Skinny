// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    private var ringo: SKShapeNode!

    var layerStack = LayerStack()

    override init(size: CGSize) {
        super.init(size: size)

//        let compensator = Layer.makeCompensator(parentSKNode: self)
//
//        ringo = Layer.makeMainRing(parentSKNode: compensator, radius: 0.95 * size.width / 2, color: .green)

        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let sceneRadius = self.frame.size.width / 2
        self.ringo = Sprites.makeRingShape(
            parentSKNode: self, radius: 0.95 * sceneRadius, color: .blue
        )

//        layerStack.addLayer(parentSKNode: ringo)

//        let spin = SKAction.rotate(byAngle: .tau, duration: 2)
//        let spinForever = SKAction.repeatForever(spin)
//        ringo.run(spinForever)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArenaScene {
    func setCarousel(_ carouselHz: Double) {
        ringo.removeAllActions()

        if carouselHz == 0 { return }
        let angle = sign(carouselHz) * .tau

        let rotate = SKAction.rotate(byAngle: angle, duration: 1 / abs(carouselHz))
        let rotateForever = SKAction.repeatForever(rotate)

        ringo.run(rotateForever)
    }
}


extension ArenaScene {
    func setDriveRate(X: Double) {
//        layerStack[0].ringShape.removeAllActions()
//
//        if hz == 0 { return }
//
//        let rotate = SKAction.rotate(byAngle: .tau, duration: 1 / hz)
//        let rotateForever = SKAction.repeatForever(rotate)
//
//        layerStack[0].ringShape.run(rotateForever)
    }
}

extension ArenaScene {
    func setRunSpeed(X: Double) {
        precondition(X >= 0, "Negative speed not yet supported")
        self.speed = X
    }
}

extension ArenaScene {
    func setViewingScale(X scaleSquared: Double) {
        ringo.setScale(sqrt(scaleSquared))
    }
}
