// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

let lineHeight = 1.0   // Thin looks good, thick is easier to debug
let maxSpinarmFraction = 0.6
let minSpinarmFraction = 0.1

class SpriteLayer: Identifiable, ObservableObject {
    let id = UUID()
    let layerIndex: Int

    let parentNode: SKNode
    let pen: SKSpriteNode
    let roller: SKSpriteNode
    let spinarm: SKSpriteNode

    @Published var penLengthFraction: Double
    @Published var spinarmFraction: Double

    let inkHue = Double.random(in: 0..<1)

    var baseRadius: CGFloat { parentNode.frame.size.width / 2 }
    var myRadius: CGFloat { roller.frame.size.width / 2 }

    var penLength: CGFloat { penLengthFraction * myRadius }
    var spinarmLength: CGFloat { spinarmFraction * baseRadius }

    init(
        layerIndex: Int, parentNode: SKNode,
        _ pen: SKSpriteNode, _ roller: SKSpriteNode, _ spinarm: SKSpriteNode
    ) {
        self.layerIndex = layerIndex
        self.parentNode = parentNode
        self.pen = pen
        self.roller = roller
        self.spinarm = spinarm

        penLengthFraction = UserDefaults.standard.double(forKey: "penLengthFraction\(layerIndex)")
        spinarmFraction = UserDefaults.standard.double(forKey: "spinarmFraction\(layerIndex)")

        pen.size = CGSize(width: penLength, height: lineHeight)
        spinarm.size = CGSize(width: spinarmLength, height: lineHeight)
    }

    func penLengthFractionChanged(_ fraction: Double) {
        UserDefaults.standard.set(fraction, forKey: "penLengthFraction\(layerIndex)")

        let resize = SKAction.resize(toWidth: self.penLength, duration: 1)
        pen.run(resize)
    }

    func spinarmLengthFractionChanged(_ fraction: Double) {
        UserDefaults.standard.set(fraction, forKey: "spinarmFraction\(layerIndex)")

        let resize = SKAction.resize(toWidth: self.spinarmLength, duration: 1)
        spinarm.run(resize)
    }
}
