// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

let lineHeight = 1.0   // Thin looks good, thick is easier to debug
let maxSpinarmFraction = 0.6
let minSpinarmFraction = 0.1
let penFraction = 0.42
let spinarmFraction = 0.95

class SpriteLayer: Identifiable, ObservableObject {
    let id = UUID()
    let layerIndex: Int

    let pen: SKSpriteNode
    let roller: SKSpriteNode
    let spinarm: SKSpriteNode

    @Published var penLength: Double
    @Published var spinarmLength: Double

    let inkHue = Double.random(in: 0..<1)

    init(layerIndex: Int, _ pen: SKSpriteNode, _ roller: SKSpriteNode, _ spinarm: SKSpriteNode) {
        self.layerIndex = layerIndex
        self.pen = pen
        self.roller = roller
        self.spinarm = spinarm

        UserDefaults.standard.set(penFraction, forKey: "penLength\(layerIndex)")
        UserDefaults.standard.set(spinarmFraction, forKey: "armLength\(layerIndex)")

        penLength = UserDefaults.standard.double(forKey: "penLength\(layerIndex)")
        spinarmLength = UserDefaults.standard.double(forKey: "armLength\(layerIndex)")

        pen.size.width = penLength * roller.size.width / 2
        spinarm.size.width = spinarmLength * roller.size.width / 2
    }

    func setPenLength(fractionOfParentRadius: Double) {
        penLength = fractionOfParentRadius * roller.size.width / 2
        UserDefaults.standard.set(penLength, forKey: "penLength\(layerIndex)")
    }

    func setSpinarmLength(fractionOfParentRadius: Double) {
        spinarmLength = fractionOfParentRadius * roller.size.width / 2
        UserDefaults.standard.set(spinarmLength, forKey: "armLength\(layerIndex)")
    }
}
