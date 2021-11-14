// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

let lineHeight = 1.0   // Thin looks good, thick is easier to debug
let maxSpinarmFraction = 0.6
let minSpinarmFraction = 0.1
let penFraction = 0.42

class SpriteLayer: Identifiable, ObservableObject {
    let id = UUID()

    let pen: SKSpriteNode
    let roller: SKSpriteNode
    let spinarm: SKSpriteNode

    @Published var penLength: Double
    @Published var spinarmLength: Double

    let inkHue = Double.random(in: 0..<1)

    init(_ pen: SKSpriteNode, _ roller: SKSpriteNode, _ spinarm: SKSpriteNode) {
        self.pen = pen
        self.roller = roller
        self.spinarm = spinarm

        penLength = pen.size.width
        spinarmLength = spinarm.size.width
    }
}
