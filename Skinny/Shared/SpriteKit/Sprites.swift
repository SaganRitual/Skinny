// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

enum Sprites {
    static func makeRingShape(
        parentSKNode: SKNode, radius: Double, color: SKColor
    ) -> SKShapeNode {
        let ringShape = SKShapeNode(circleOfRadius: radius)
        parentSKNode.addChild(ringShape)
        ringShape.strokeColor = color

        var p0 = [CGPoint(x: 0.9 * radius, y: 0), CGPoint(x: radius, y: 0)]
        var p1 = [CGPoint(x: 0, y: 0.9 * radius), CGPoint(x: 0, y: radius)]
        var p2 = [CGPoint(x: -0.9 * radius, y: 0), CGPoint(x: -radius, y: 0)]
        var p3 = [CGPoint(x: 0, y: -0.9 * radius), CGPoint(x: 0, y: -radius)]

        let s0 = SKShapeNode(points: &p0, count: 2)
        let s1 = SKShapeNode(points: &p1, count: 2)
        let s2 = SKShapeNode(points: &p2, count: 2)
        let s3 = SKShapeNode(points: &p3, count: 2)

        for s in [s0, s1, s2, s3] {

            s.lineWidth = 1
            s.strokeColor = color
            s.fillColor = color

            s.zRotation = Double.random(in: 0..<1) * .tau

            ringShape.addChild(s)
        }

        return ringShape
    }
}
