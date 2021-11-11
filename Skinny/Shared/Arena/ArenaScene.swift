// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    @Published var readyToRun = false

    private var ringo: SKShapeNode!

    var layerStack = LayerStack()

    override init(size: CGSize) {
        super.init(size: size)

        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {

        let sceneRadius = self.frame.size.effectiveRadius
        self.ringo = Sprite.makeMainRing(
            parentSKNode: self, radius: 0.95 * sceneRadius, color: .blue
        )

        layerStack.addLayer(parentSKNode: ringo)

        readyToRun = true
    }
}

extension ArenaScene {
    func setCarousel(_ carouselHz: Double) {
        ringo.removeAllActions()

        if carouselHz == 0 { return }
        let angle = sign(carouselHz) * carouselHz * .tau

        let rotate = SKAction.rotate(byAngle: angle, duration: 1 / abs(carouselHz))
        let rotateForever = SKAction.repeatForever(rotate)

        ringo.run(rotateForever)
    }
}


extension ArenaScene {
    func setDriveRate(_ driveHz: Double) {
        let driverRing = layerStack[0].radiusShape
        let driverCompensator = layerStack[0].compensatorShape

        driverRing.removeAllActions()
        driverCompensator.removeAllActions()

        if driveHz == 0 { return }
        let angle = sign(driveHz) * .tau
        let duration = 1 / abs(driveHz)

        let rotate = SKAction.rotate(byAngle: angle, duration: duration)
        let antiRotate = SKAction.rotate(byAngle: -angle, duration: duration)

        driverRing.run(SKAction.repeatForever(rotate))
        driverCompensator.run(SKAction.repeatForever(antiRotate))
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
