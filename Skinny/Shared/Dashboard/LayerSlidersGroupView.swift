// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct LayerSlidersGroupView: View {
    @EnvironmentObject var arenaScene: ArenaScene
    @EnvironmentObject var spriteLayer: SpriteLayer

    var body: some View {
        VStack {
            SliderView(
                label: "Pen", labellet: "Xr", range: 0...1, step: 0.025,
                value: $spriteLayer.penLength
            )
            .padding(.trailing, 10)
            .controlSize(.small)
            .monospacedDigit()
            .allowsTightening(false)
            .minimumScaleFactor(1)
            .lineLimit(1)
            .help("Length of the pen as a fraction of the ring radius")
            .onChange(of: spriteLayer.penLength) { _ in /*spriteLayer.setPenLength($0)*/ }

            SliderView(
                label: "Radius", labellet: "Xp", range: 0...1, step: 0.025,
                value: $spriteLayer.radiusFraction
            )
            .padding(.trailing, 10)
            .controlSize(.small)
            .monospacedDigit()
            .allowsTightening(false)
            .minimumScaleFactor(1)
            .lineLimit(1)
            .help("Length of the radius as a fraction of the parent ring radius")
            .onChange(of: spriteLayer.radiusFraction) { _ in /*spriteLayer.setRadiusFraction($0)*/ }
        }
    }
}
