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
        let pn = layerIndex == 0 ?
            (parentNode as? ArenaScene)! : (parentNode as? SKSpriteNode)!

        let spinarm = makeSpinarm(parentNode: parentNode, color: color)
        let roller = makeRoller(spinarm: spinarm)
        let pen = makePen(rollerSprite: roller)

        return SpriteLayer(
            layerIndex: layerIndex, baseRadius: pn.frame.size.width / 2, pen, roller, spinarm
        )
    }
}

extension SpriteLayerFactory {
    func makeRoller(spinarm: SKSpriteNode) -> SKSpriteNode {
        let size = CGSize(width: spinarm.size.width, height: spinarm.size.width)

        let rollerSprite = ringsPool.makeSprite()

        rollerSprite.color = spinarm.color
        rollerSprite.size = CGSize(width: size.width, height: lineHeight)
        rollerSprite.position = CGPoint(x: -spinarm.frame.size.width, y: 0)

        spinarm.addChild(rollerSprite)

        return rollerSprite
    }

    func makePen(rollerSprite: SKSpriteNode) -> SKSpriteNode {
        let penSprite = linesPool.makeSprite()

        penSprite.anchorPoint = CGPoint(x: 0, y: 0.5)

        penSprite.color = rollerSprite.color
        penSprite.size = CGSize(
            width: penFraction * rollerSprite.size.width / 2, height: lineHeight
        )

        rollerSprite.addChild(penSprite)

        return rollerSprite
    }

    func makeSpinarm(
        parentNode: SKNode, color: SKColor
    ) -> SKSpriteNode {
        let parentRollerRadius = parentNode.frame.size.width / 2
        let size = CGSize(width: maxSpinarmFraction * parentRollerRadius, height: lineHeight)

        let spinnerSprite = linesPool.makeSprite()
        spinnerSprite.anchorPoint = CGPoint(x: 0, y: 0.5)

        spinnerSprite.color = color
        spinnerSprite.size = size

        parentNode.addChild(spinnerSprite)

//        // To make it visually interesting while I debug
//        let throbPlus = SKAction.resize(toWidth: maxSpinarmFraction * arenaScene.frame.size.width / 2, duration: sqrt(2))
//        throbPlus.timingMode = .easeInEaseOut
//        let throbMinus = SKAction.resize(toWidth: minSpinarmFraction * arenaScene.frame.size.width / 2, duration: sqrt(3))
//        throbMinus.timingMode = .easeInEaseOut
//        let throb = SKAction.sequence([throbPlus, throbMinus])
//        let throbForever = SKAction.repeatForever(throb)
//
//        spinnerSprite.run(throbForever)

        return spinnerSprite
    }
}

