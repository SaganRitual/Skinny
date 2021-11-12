// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class LayerStack: ObservableObject, RandomAccessCollection {
    var startIndex: Int = 0
    var endIndex: Int { layers.count }

    var layers = [SpriteLayer]()

    subscript(position: Int) -> SpriteLayer { layers[position] }

    let colors: [SKColor] = [
        .cyan, .magenta, .yellow, .red, .green
//        .clear, .clear, .clear, .clear, .clear
    ]

    let initialRadiusFractions = [0.4, 0.2]
}
