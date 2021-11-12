// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    @Published var readyToRun = false

    let dotsPool: SpritePool

    static let baseDriveAngle = Double.tau

    var layerStack = LayerStack()
    var sceneRing: SKShapeNode!
    var tickCount = 0

    override init(size: CGSize) {
        self.dotsPool = SpritePool("Markers", "circle-solid", cPreallocate: 10000)

        super.init(size: size)

        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        let sceneRadius = self.frame.size.width / 2
        sceneRing = Sprite.makeMainRing(
            parentSKNode: self, radius: 0.95 * sceneRadius, color: .blue
        )

        let driveAngle0 = ArenaScene.baseDriveAngle

        layerStack.layers.append(SpriteLayer(
            parentNode: sceneRing, color: .magenta,
            radiusFraction: 0.5, driveAngle: driveAngle0
        ))

        let driveAngle1 = -(1.0 / layerStack.initialRadiusFractions[0]) * driveAngle0
        let radiusFraction1 = layerStack.initialRadiusFractions[0]

        layerStack.layers.append(SpriteLayer(
            parentNode: layerStack.layers[0].roller0, color: .orange,
            radiusFraction: radiusFraction1, driveAngle: driveAngle1
        ))

        let driveAngle2 = -(1.0 / layerStack.initialRadiusFractions[1]) * driveAngle1
        let radiusFraction2 = layerStack.initialRadiusFractions[1]

        layerStack.layers.append(SpriteLayer(
            parentNode: layerStack.layers[1].roller0, color: .green,
            radiusFraction: radiusFraction2, driveAngle: driveAngle2
        ))

        readyToRun = true
    }

    override func update(_ currentTime: TimeInterval) {
        tickCount += 1
    }
}

extension ArenaScene {
    func setCarousel(_ carouselHz: Double) {
        sceneRing.removeAllActions()

        if carouselHz == 0 { return }
        let angle = sign(carouselHz) * .tau

        let rotate = SKAction.rotate(byAngle: angle, duration: 1 / abs(carouselHz))
        let rotateForever = SKAction.repeatForever(rotate)

        sceneRing.run(rotateForever)
    }
}

extension ArenaScene {
    func setDriveRate(_ driveHz: Double) {
//        let driverRing = layerStack[0].radiusShape
//        let driverCompensator = layerStack[0].compensatorShape
//
//        driverRing.removeAllActions()
//        driverCompensator.removeAllActions()
//
//        if driveHz == 0 { return }
//        let angle = sign(driveHz) * .tau
//        let duration = 1 / abs(driveHz)
//
//        let rotate = SKAction.rotate(byAngle: angle, duration: duration)
//        let antiRotate = SKAction.rotate(byAngle: -angle, duration: duration)
//
//        driverRing.run(SKAction.repeatForever(rotate))
//        driverCompensator.run(SKAction.repeatForever(antiRotate))
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
        sceneRing?.setScale(sqrt(scaleSquared))
    }
}
