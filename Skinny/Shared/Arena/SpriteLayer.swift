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

    @Published var baseRadius: Double
    @Published var penLength: Double
    @Published var spinarmLength: Double

    let inkHue = Double.random(in: 0..<1)

    init(
        layerIndex: Int, baseRadius: Double,
        _ pen: SKSpriteNode, _ roller: SKSpriteNode, _ spinarm: SKSpriteNode
    ) {
        self.layerIndex = layerIndex
        self.baseRadius = baseRadius
        self.pen = pen
        self.roller = roller
        self.spinarm = spinarm

        penLength = UserDefaults.standard.double(forKey: "penLength\(layerIndex)")
        spinarmLength = UserDefaults.standard.double(forKey: "armLength\(layerIndex)")

        pen.size.width = penLength * roller.size.width
        spinarm.size.width = spinarmLength * baseRadius
    }

    func setPenLength(fractionOfParentRadius: Double) {
        print("resize pen from \(penLength) to \(fractionOfParentRadius)")
        penLength = fractionOfParentRadius
        UserDefaults.standard.set(penLength, forKey: "penLength\(layerIndex)")

        let resize = SKAction.resize(toWidth: penLength * roller.size.width, duration: 1)
        pen.run(resize)
    }

    func setSpinarmLength(fractionOfParentRadius: Double) {
        spinarmLength = fractionOfParentRadius
        print("spinarmLength \(spinarmLength)")
        UserDefaults.standard.set(spinarmLength, forKey: "armLength\(layerIndex)")

        let resize = SKAction.resize(toWidth: spinarmLength * baseRadius, duration: 1)
        spinarm.run(resize)
    }
}
