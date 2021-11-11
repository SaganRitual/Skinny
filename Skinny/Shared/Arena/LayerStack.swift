// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class LayerStack: ObservableObject, RandomAccessCollection {
    var startIndex: Int = 0
    var endIndex: Int { layers.count }

    var layers = [SpriteLayer]()

    subscript(position: Int) -> SpriteLayer { layers[position] }

    private let colors: [SKColor] = [
        .cyan, .magenta, .yellow, .red, .green
    ]

    private let initialRadiusFractions: [Double] = [
        0.5, 0.5, 0.5, 0.5, 0.5
    ]

    func addLayer(parentSKNode: SKNode) {
        let color = colors[layers.count]
        let radiusFraction = initialRadiusFractions[layers.count]

        let newLayer = SpriteLayer(
            layerIndex: layers.count, parentSKNode: parentSKNode, color: color,
            radiusFraction: radiusFraction
        )

        layers.append(newLayer)
    }
}
