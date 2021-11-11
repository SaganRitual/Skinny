// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class SpriteLayer: ObservableObject, Identifiable {
    let id = UUID()

    let ringTransport: SKShapeNode
//    let penShape: SKShapeNode
//    let ringShape: SKShapeNode

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

        SpriteLayer.startTransport(
            ringTransport: ringTransport,
            parentSKNode: parentSKNode,
            myTransportRadius: myTransportRadius
        )
    }
}

extension SpriteLayer {
    static func startTransport(
        ringTransport: SKNode, parentSKNode: SKNode, myTransportRadius: Double
    ) {
        let myTransportDiameter = myTransportRadius * 2
        let transportPathOrigin = CGPoint(x: -myTransportRadius, y: -myTransportRadius)
        let transportPathSize = CGSize(width: myTransportDiameter, height: myTransportDiameter)
        let transportPathRect = CGRect(origin: transportPathOrigin, size: transportPathSize)
        let transportPath = CGMutablePath(ellipseIn: transportPathRect, transform: nil)

        let debugRingTransport = SKShapeNode(path: transportPath)
        debugRingTransport.strokeColor = .yellow
        parentSKNode.addChild(debugRingTransport)

        let action = SKAction.follow(
            transportPath, asOffset: false, orientToPath: false, duration: 1
        )

        let rf = SKAction.repeatForever(action)
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
        shapeNode.fillColor = .blue
        shapeNode.strokeColor = .clear

        parentSKNode.addChild(shapeNode)
        return shapeNode
    }
}
