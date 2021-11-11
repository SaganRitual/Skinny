// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

enum Sprite {
    static func startActions(
        layerIndex: Int, compensatorShape: SKShapeNode,
        penShape: SKShapeNode, radiusShape: SKShapeNode,
        parentRingRadius: Double
    ) {
        let direction = Double.tau * ((layerIndex % 2 == 0) ? 1.0 : -1.0)
        let ringCycleDuration = 1.0// 1 / settings.rotationRateHz
        let ringRadius = radiusShape.frame.size.width / 2
        let penCycleDuration = ringCycleDuration * (parentRingRadius / ringRadius)

        let penSpinAction = SKAction.rotate(byAngle: -direction, duration: penCycleDuration)
        let penSpinForever = SKAction.repeatForever(penSpinAction)

        let spinAction = SKAction.rotate(byAngle: direction, duration: ringCycleDuration)
        let spinForever = SKAction.repeatForever(spinAction)

        let compensateAction = SKAction.rotate(byAngle: -direction, duration: ringCycleDuration)
        let compensateForever = SKAction.repeatForever(compensateAction)

        compensatorShape.run(compensateForever)
        penShape.run(penSpinForever)
        radiusShape.run(spinForever)
    }

    /*

     let direction = Double.tau * ((layerIndex % 2 == 0) ? -1.0 : 1.0)
     let ringCycleDuration = 1.0// 1 / settings.rotationRateHz
     let penCycleDuration = ringCycleDuration * (ringRadius / parentLayer.ringRadius())

     let penSpinAction = SKAction.rotate(byAngle: -direction, duration: penCycleDuration)
     let penSpinForever = SKAction.repeatForever(penSpinAction)

     let spinAction = SKAction.rotate(byAngle: direction, duration: ringCycleDuration)
     let spinForever = SKAction.repeatForever(spinAction)

     let compensateAction = SKAction.rotate(byAngle: -direction, duration: ringCycleDuration)
     let compensateForever = SKAction.repeatForever(compensateAction)

     compensator.run(compensateForever)
     penShape.run(penSpinForever)
     spacerShape.run(spinForever)

     */

    static func makeCompensator(
        parentSKNode: SKNode, radius: Double
    ) -> SKShapeNode {
        let sCompensator = CGSize(width: 1, height: 1)
        let oCompensator = CGPoint(x: -0.5, y: -0.5)
        let rCompensator = CGRect(origin: oCompensator, size: sCompensator)

        let compensatorShape = SKShapeNode(rect: rCompensator)

        compensatorShape.position = CGPoint(x: radius, y: 0)
        compensatorShape.fillColor = .blue
        compensatorShape.strokeColor = .clear

        parentSKNode.addChild(compensatorShape)
        return compensatorShape
    }

    static func makeMainRing(
        parentSKNode: SKNode, radius: Double, color: SKColor
    ) -> SKShapeNode {

        let ringShape = SKShapeNode(circleOfRadius: radius)
        parentSKNode.addChild(ringShape)
        ringShape.strokeColor = color

        #if DEBUG
        var pSpinIndicator: [CGPoint] = [CGPoint(x: 0.8 * radius, y: 0), CGPoint(x: radius, y: 0)]
        let spinIndicatorShape = SKShapeNode(points: &pSpinIndicator, count: 2)
        spinIndicatorShape.lineWidth = 1
        spinIndicatorShape.strokeColor = color
        spinIndicatorShape.fillColor = color
        ringShape.addChild(spinIndicatorShape)
        #endif

        return ringShape
    }

    static func makePenShape(
        parentSKNode: SKNode, radius: Double, color: SKColor
    ) -> SKShapeNode {
        let penFraction = 1.0//settings.penLengthFraction
        let penLength = penFraction * radius

        var pPen: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: penLength, y: 0)]

        let penShape = SKShapeNode(points: &pPen, count: 2)
        penShape.strokeColor = color
        penShape.zRotation += .tau / 4

        parentSKNode.addChild(penShape)
        return penShape
    }

    static func makePenTipShape(
        parentSKNode: SKNode, penLength: Double
    ) -> SKNode {
        let penTip = SKNode()
        penTip.position = CGPoint(x: penLength, y: 0)

        parentSKNode.addChild(penTip)
        return penTip
    }

    static func makeRadiusShape(
        parentSKNode: SKNode, radius: Double, color: SKColor
    ) -> SKShapeNode {
        var pRadius: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: radius, y: 0)]

        let radiusShape = SKShapeNode(points: &pRadius, count: 2)
        radiusShape.strokeColor = color

        parentSKNode.addChild(radiusShape)
        return radiusShape
    }
}
