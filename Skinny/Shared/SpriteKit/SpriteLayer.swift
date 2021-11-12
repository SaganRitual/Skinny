// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class SpriteLayer: ObservableObject, Identifiable {
    let id = UUID()

    @Published var showPen = true
    @Published var showRadius = true
    @Published var showCenters = true
    @Published var showRing = true

    @Published var penLength = 0.67

    let pen0: SKShapeNode
    let roller0: SKShapeNode
    let spinner0: SKShapeNode

    @Published var radiusFraction = 0.75
    @Published var radiusReciprocal = 0.25

    init(
        parentNode: SKNode, color: SKColor,
        radiusFraction: Double, driveAngle: Double,
        runActions: Bool = true
    ) {
        let parentRadius = parentNode.frame.size.width / 2
        let primaryRadius = parentRadius * (1 - radiusFraction)
        let pRoller = CGPoint(x: primaryRadius, y: 0)
        roller0 = SKShapeNode(circleOfRadius: parentRadius * radiusFraction)
        roller0.position = pRoller
        roller0.strokeColor = color

        spinner0 = SKShapeNode(circleOfRadius: parentRadius * (1 - radiusFraction))
        spinner0.strokeColor = color

        let pen0Fraction = 0.67
        let pen0Length = pen0Fraction * primaryRadius
        let pen0Origin = CGPoint.zero
        let pen0Size = CGSize(width: pen0Length, height: 0.5)
        var pen0Path = [pen0Origin, pen0Size.asPoint()]

        pen0 = SKShapeNode(points: &pen0Path, count: 2)
        pen0.strokeColor = color.withAlphaComponent(0.2)
        pen0.lineWidth = 0.5

        parentNode.addChild(spinner0)
        spinner0.addChild(roller0)
        roller0.addChild(pen0)

        self.radiusFraction = radiusFraction
        self.radiusReciprocal = 1 - radiusFraction

        if runActions == false { return }

        let angle = driveAngle * radiusFraction
        let spinAction = SKAction.rotate(byAngle: angle, duration: 1)
        let spinForever = SKAction.repeatForever(spinAction)
        spinner0.run(spinForever)

        let rollAction = SKAction.rotate(byAngle: -2 * angle, duration: 1)
        let rollForever = SKAction.repeatForever(rollAction)
        roller0.run(rollForever)
    }
}
