// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

extension ArenaScene {
    override func didEvaluateActions() {
        let hue = Double(tickCount % 600) / 600
        let color = NSColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)

        for ix in 0..<layerStack.count {
            let easyDot = dotsPool.makeSprite()
            easyDot.size = CGSize(width: 2, height: 2)
            easyDot.color = color
            easyDot.alpha = 0.85

            let xOtherEnd = layerStack[ix].pen0.frame.size.width
            let pOtherEnd = CGPoint(x: xOtherEnd, y: 0)
            let dotPosition = layerStack[ix].pen0.convert(pOtherEnd, to: self)

            easyDot.position = dotPosition
            self.addChild(easyDot)

            let pathFadeDurationSeconds = AppSettingsView.pathFadeDurationSeconds * self.speed
            let fade = SKAction.fadeOut(withDuration: pathFadeDurationSeconds)
            easyDot.run(fade) {
                self.dotsPool.releaseSprite(easyDot)
            }
        }
    }
}
