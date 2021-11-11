// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class SpriteLayer: ObservableObject, Identifiable {
    let id = UUID()

    let penShape: SKShapeNode
    let penTip: SKNode
    let ringShape: SKShapeNode
    let ringTransport: SKShapeNode

    init(
        layerIndex: Int, parentSKNode: SKNode,
        color: SKColor, radiusFraction: Double
    ) {
        let parentRadius = parentSKNode.frame.size.width / 2
        let myRingRadius = radiusFraction * parentRadius
        let myTransportRadius = parentRadius - myRingRadius

        self.ringTransport = SpriteLayer.makeRingTransport(
            parentSKNode: parentSKNode, radius: myRingRadius
        )

        self.ringShape = SpriteLayer.makeRing(
            parentSKNode: ringTransport, radius: myRingRadius
        )

        self.penShape = SpriteLayer.makePen(
            parentSKNode: ringShape, length: myRingRadius * 0.75
        )

        self.penTip = SpriteLayer.makePenTip(parentSKNode: penShape)

        SpriteLayer.startTransport(
            layerIndex: layerIndex,
            ringTransport: ringTransport,
            parentSKNode: parentSKNode,
            myTransportRadius: myTransportRadius
        )
    }
}

extension SpriteLayer {
    static func startTransport(
        layerIndex: Int,
        ringTransport: SKNode, parentSKNode: SKNode, myTransportRadius: Double
    ) {
        let myTransportDiameter = myTransportRadius * 2
        let transportPathOrigin = CGPoint(x: -myTransportRadius, y: -myTransportRadius)
        let transportPathSize = CGSize(width: myTransportDiameter, height: myTransportDiameter)
        let transportPathRect = CGRect(origin: transportPathOrigin, size: transportPathSize)
        let transportPath = CGMutablePath(ellipseIn: transportPathRect, transform: nil)

        let debugRingTransport = SKShapeNode(path: transportPath)
        debugRingTransport.strokeColor = .clear//.yellow
        parentSKNode.addChild(debugRingTransport)

        let follow_ = SKAction.follow(
            transportPath, asOffset: false, orientToPath: false, duration: 1
        )

        let follow = (layerIndex % 2 == 0) ? follow_ : follow_.reversed()

        let spinAngle = (layerIndex % 2 == 0) ? -Double.tau : Double.tau

        let spin = SKAction.rotate(byAngle: spinAngle, duration: 1)

        let group = SKAction.group([follow, spin])
        let rf = SKAction.repeatForever(group)

        ringTransport.run(rf)
    }
}

extension SpriteLayer {
    static func makeRingTransport(
        parentSKNode: SKNode, radius: Double
    ) -> SKShapeNode {
        let size = CGSize(width: 10, height: 10)
        let origin = CGPoint(x: -5, y: -5)
        let rectangle = CGRect(origin: origin, size: size)

        let shapeNode = SKShapeNode(rect: rectangle)

        shapeNode.position = CGPoint(x: radius, y: 0)
        shapeNode.fillColor = .clear //.blue
        shapeNode.strokeColor = .clear

        parentSKNode.addChild(shapeNode)
        return shapeNode
    }

    static func makeRing(
        parentSKNode: SKNode, radius: Double
    ) -> SKShapeNode {
        let origin = CGPoint(x: -5 + parentSKNode.frame.size.width / 2, y: 0)

        let shapeNode = SKShapeNode(circleOfRadius: radius)

        shapeNode.position = origin
        shapeNode.fillColor = .clear
        shapeNode.strokeColor = .clear//.green

        parentSKNode.addChild(shapeNode)
        return shapeNode
    }

    static func makePen(
        parentSKNode: SKNode, length: Double
    ) -> SKShapeNode {
        var pathPoints: [CGPoint] = [
            CGPoint.zero, CGPoint(x: length, y: 0)
        ]

        let shapeNode = SKShapeNode(points: &pathPoints, count: 2)
        shapeNode.position = .zero
        shapeNode.fillColor = .clear

        // Weird; if we make the stroke color .clear, it's as though the pen
        // isn't being created, so the pen tip looks like it's attached to the
        // transport
        shapeNode.strokeColor = SKColor(calibratedWhite: 0.01, alpha: 0.01)

        parentSKNode.addChild(shapeNode)
        return shapeNode
    }

    static func makePenTip(parentSKNode: SKNode) -> SKNode {
        let node = SKNode()
        node.position.x = parentSKNode.frame.size.width / 2
        parentSKNode.addChild(node)
        return node
    }
}
