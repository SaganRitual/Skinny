// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class SpriteLayer: ObservableObject, Identifiable {
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
    let penTipShape: SKNode
    let radiusShape: SKShapeNode
    let ringShape: SKShapeNode

    init(
        layerIndex: Int, parentSKNode: SKNode,
        color: SKColor, radiusFraction: Double
    ) {
        let parentRadius = parentSKNode.frame.size.width / 2
        let mRadius = radiusFraction * parentRadius

        self.radiusShape = Sprite.makeRadiusShape(
            parentSKNode: parentSKNode, radius: mRadius, color: color
        )

        self.compensatorShape = Sprite.makeCompensator(
            parentSKNode: radiusShape, radius: mRadius
        )

        self.ringShape = Sprite.makeMainRing(
            parentSKNode: compensatorShape, radius: mRadius, color: color
        )

        self.penShape = Sprite.makePenShape(
            parentSKNode: compensatorShape, radius: mRadius, color: color)

        self.penTipShape = Sprite.makePenTipShape(
            parentSKNode: penShape, penLength: mRadius
        )

        self.radiusFraction = radiusFraction
        self.parentRadius = parentRadius

        if layerIndex > 0 { return }

        Sprite.startActions(
            layerIndex: layerIndex, compensatorShape: compensatorShape,
            penShape: penShape, radiusShape: radiusShape,
            parentRingRadius: parentRadius
        )
    }
}
