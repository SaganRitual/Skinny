// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class Layer: ObservableObject, Identifiable {
    let id = UUID()

    @Published var showCenters = true
    @Published var showPen = true
    @Published var showRadius = true
    @Published var showRing = true

    @Published var parentRadius: Double
    @Published var penLength = 1.0
    @Published var radiusFraction: Double

    let compensatorShape: SKShapeNode
    let penShape: SKShapeNode
    let penTipShape: SKShapeNode
    let radiusShape: SKShapeNode
    let ringShape: SKShapeNode

    init(
        layerIndex: Int, parentSKNode: SKNode,
        color: SKColor, radiusFraction: Double
    ) {
        let parentRadius = parentSKNode.frame.width / 2
        let mRadius = radiusFraction * parentRadius

        self.radiusShape = Layer.makeRadiusShape(
            parentSKNode: parentSKNode, radius: mRadius, color: color
        )

        self.compensatorShape = Layer.makeCompensator(parentSKNode: radiusShape)

        self.ringShape = Layer.makeMainRing(
            parentSKNode: compensatorShape, radius: mRadius, color: color
        )

        self.penShape = Layer.makePenShape(
            parentSKNode: compensatorShape, radius: mRadius, color: color)

        self.penTipShape = Layer.makePenTipShape(
            parentSKNode: penShape, penLength: mRadius
        )

        self.radiusFraction = radiusFraction
        self.parentRadius = parentRadius

        if layerIndex > 0 { return }

        Layer.startActions(
            layerIndex: layerIndex, compensatorShape: compensatorShape,
            penShape: penShape, radiusShape: radiusShape,
            parentRingRadius: parentRadius
        )
    }
}

private extension Layer {
    static func startActions(
        layerIndex: Int, compensatorShape: SKShapeNode,
        penShape: SKShapeNode, radiusShape: SKShapeNode,
        parentRingRadius: Double
    ) {
        let direction = Double.tau * ((layerIndex % 2 == 0) ? 1.0 : -1.0)
        let ringCycleDuration = 1.0// 1 / settings.rotationRateHz
        let ringRadius = radiusShape.frame.size.width / 2
        let penCycleDuration = ringCycleDuration * (ringRadius / parentRingRadius)

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
}

extension Layer {
    static func makeCompensator(parentSKNode: SKNode) -> SKShapeNode {
        let sCompensator = CGSize(width: 1, height: 1)
        let oCompensator = CGPoint(x: -0.5, y: -0.5)
        let rCompensator = CGRect(origin: oCompensator, size: sCompensator)

        let compensatorShape = SKShapeNode(rect: rCompensator)

        compensatorShape.position = .zero
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
}

private extension Layer {
    static func makePenShape(
        parentSKNode: SKNode, radius: Double, color: SKColor
    ) -> SKShapeNode {
        let penFraction = 1.0//settings.penLengthFraction
        let penLength = penFraction * radius

        var pPen: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: penLength, y: 0)]

        let penShape = SKShapeNode(points: &pPen, count: 2)
        penShape.strokeColor = color
        penShape.zRotation += .tau / 4

//        parentSKNode.addChild(penShape)
        return penShape
    }

    static func makePenTipShape(
        parentSKNode: SKNode, penLength: Double
    ) -> SKShapeNode {

        let penTip = SKShapeNode(circleOfRadius: 2)
        penTip.position = CGPoint(x: penLength, y: 0)
        penTip.strokeColor = .clear

//        parentSKNode.addChild(penTip)
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
