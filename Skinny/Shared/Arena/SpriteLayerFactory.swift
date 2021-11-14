// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class SpriteLayerFactory {
    let dotsPool = SpritePool("Markers", "circle-solid", cPreallocate: 10000)
    let linesPool = SpritePool("Markers", "line")
    let ringsPool = SpritePool("Markers", "circle")

    let arenaScene: ArenaScene

    init(arenaScene: ArenaScene) {
        self.arenaScene = arenaScene
    }

    func makeLayer(layerIndex: Int, parentNode: SKNode, color: SKColor) -> SpriteLayer {
        let spinarm = makeSpinarm(parentNode: parentNode, color: color)
        let roller = makeRoller(spinarm: spinarm)
        let pen = makePen(rollerSprite: roller)

        return SpriteLayer(
            layerIndex: layerIndex, parentNode: parentNode, pen, roller, spinarm
        )
    }
}

extension SpriteLayerFactory {
    func makeRoller(spinarm: SKSpriteNode) -> SKSpriteNode {
        let frameSize = CGSize(width: spinarm.frame.size.width, height: lineHeight)

        let rollerSprite = ringsPool.makeSprite()

        rollerSprite.color = .red//spinarm.color
        rollerSprite.size = frameSize
        rollerSprite.position = CGPoint(x: -frameSize.width, y: 0)

        spinarm.addChild(rollerSprite)

        return rollerSprite
    }

    func makePen(rollerSprite: SKSpriteNode) -> SKSpriteNode {
        let penSprite = linesPool.makeSprite()

        penSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
        penSprite.color = .green//rollerSprite.color

        penSprite.size.height = 1
        rollerSprite.addChild(penSprite)

        return rollerSprite
    }

    func makeSpinarm(
        parentNode: SKNode, color: SKColor
    ) -> SKSpriteNode {
        let spinarmSprite = linesPool.makeSprite()

        spinarmSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
        spinarmSprite.color = .blue//color

        parentNode.addChild(spinarmSprite)

//        // To make it visually interesting while I debug
//        let throbPlus = SKAction.resize(toWidth: maxSpinarmFraction * arenaScene.frame.size.width / 2, duration: sqrt(2))
//        throbPlus.timingMode = .easeInEaseOut
//        let throbMinus = SKAction.resize(toWidth: minSpinarmFraction * arenaScene.frame.size.width / 2, duration: sqrt(3))
//        throbMinus.timingMode = .easeInEaseOut
//        let throb = SKAction.sequence([throbPlus, throbMinus])
//        let throbForever = SKAction.repeatForever(throb)
//
//        spinnerSprite.run(throbForever)

        return spinarmSprite
    }
}

