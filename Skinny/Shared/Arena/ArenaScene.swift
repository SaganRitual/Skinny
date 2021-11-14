// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    @Published var layers = [SpriteLayer]()
    var tickCount = 0

    lazy var layerFactory = SpriteLayerFactory(arenaScene: self)

    var driveRateShadow = 0.0
    var runSpeedShadow = 0.0

    override init(size: CGSize) {
        super.init(size: size)

        backgroundColor = SKColor.init(calibratedWhite: 0.1, alpha: 0.1)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        speed = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        let sceneRing = layerFactory.ringsPool.makeSprite()
        sceneRing.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        sceneRing.color = .cyan
        sceneRing.size = self.frame.size

        self.addChild(sceneRing)

        let magenta = NSColor.magenta.withAlphaComponent(0.8)
        let orange = NSColor.orange.withAlphaComponent(0.1)

        layers.append(layerFactory.makeLayer(layerIndex: 0, parentNode: self, color: magenta))
//        layers.append(layerFactory.makeLayer(layerIndex: 1, parentNode: layers[0].roller, color: orange))
    }

    static let rotationPeriodSeconds: TimeInterval = 10

    override func update(_ currentTime: TimeInterval) {
        tickCount += 1

        let hue = Double(tickCount % 600) / 600

        for layer in layers {
            let adjustedHue = (layer.inkHue + hue).truncatingRemainder(dividingBy: 1)
            let color = NSColor(hue: adjustedHue, saturation: 1, brightness: 1, alpha: 1)

            layer.roller.position = CGPoint(x: layer.spinarm.size.width, y: 0)
            layer.roller.size.width = 2 * ((frame.size.width / 2) - layer.spinarm.size.width)
            layer.roller.size.height = layer.roller.size.width

            let fractionToSceneRadius = frame.size.width / layer.roller.size.width
            let rollAngle = fractionToSceneRadius * Double.tau / (60 / self.runSpeedShadow / self.driveRateShadow)

            let spinAngle = Double.tau / (60 / self.runSpeedShadow / self.driveRateShadow)

            layer.spinarm.zRotation += spinAngle
            layer.roller.zRotation -= spinAngle + rollAngle

            let easyDot = layerFactory.dotsPool.makeSprite()
            easyDot.size = CGSize(width: 5, height: 5)
            easyDot.color = color
            easyDot.alpha = 0.85

            let tipPosition = CGPoint(x: layer.penLength, y: 0)
            let dotPosition = layer.pen.convert(tipPosition, to: self)

            easyDot.position = dotPosition
            self.addChild(easyDot)

            let pathFadeDurationSeconds: TimeInterval = 2
            let fade = SKAction.fadeOut(withDuration: pathFadeDurationSeconds)
            easyDot.run(fade) {
                self.layerFactory.dotsPool.releaseSprite(easyDot)
            }
        }
    }
}

extension ArenaScene {
}

extension ArenaScene {
    func setRunSpeed(X: Double) {
//        precondition(X >= 0, "Negative speed not yet supported")
//        self.speed = X
    }
}

extension ArenaScene {
    func setViewingScale(X scaleSquared: Double) {
//        sceneRing?.setScale(sqrt(scaleSquared))
    }
}

extension ArenaScene {
    func setCarousel(_ carouselHz: Double) {
        UserDefaults.standard.set(carouselHz, forKey: "carouselHz")
        
//        sceneRing.removeAllActions()
//
//        if carouselHz == 0 { return }
//        let angle = sign(carouselHz) * .tau
//
//        let rotate = SKAction.rotate(byAngle: angle, duration: 1 / abs(carouselHz))
//        let rotateForever = SKAction.repeatForever(rotate)
//
//        sceneRing.run(rotateForever)
    }
}
