// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class SpriteLayer: ObservableObject, Identifiable {
    let id = UUID()

    let pen0: SKShapeNode
    let roller0: SKShapeNode
    let spinner0: SKShapeNode

    let radiusFraction = 0.75
    let radiusReciprocal = 0.25

    init(
        parentNode: SKNode, color: SKColor, driveAngle: Double,
        runActions: Bool = true
    ) {
        let parentRadius = parentNode.frame.size.width / 2
        let primaryRadius = parentRadius * radiusReciprocal
        let pRoller = CGPoint(x: primaryRadius, y: 0)
        roller0 = SKShapeNode(circleOfRadius: parentRadius * radiusFraction)
        roller0.position = pRoller
        roller0.strokeColor = color

        spinner0 = SKShapeNode(circleOfRadius: parentRadius * radiusReciprocal)
        spinner0.strokeColor = color

        let pen0Fraction = 0.67
        let pen0Length = pen0Fraction * primaryRadius
        let pen0Origin = CGPoint.zero
        let pen0Size = CGSize(width: pen0Length, height: 1)
        let pen0Rect = CGRect(origin: pen0Origin, size: pen0Size)
        pen0 = SKShapeNode(rect: pen0Rect)
        pen0.strokeColor = color

        parentNode.addChild(spinner0)
        spinner0.addChild(roller0)
        roller0.addChild(pen0)

        if runActions == false { return }

        let angle = driveAngle * parentRadius / primaryRadius
        let spinAction = SKAction.rotate(byAngle: angle, duration: 1)
        let spinForever = SKAction.repeatForever(spinAction)
        spinner0.run(spinForever)

        let rollAction = SKAction.rotate(byAngle: -2 * angle, duration: 1)
        let rollForever = SKAction.repeatForever(rollAction)
        roller0.run(rollForever)
    }
}
