// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct LayerSlidersGroupView: View {
    @EnvironmentObject var arenaScene: ArenaScene
    @EnvironmentObject var spriteLayer: SpriteLayer

    var body: some View {
        VStack {
            SliderView(
                label: "Spin arm", labellet: "Xp",
                range: 0.05...0.95, step: 0.1,
                value: $spriteLayer.spinarmFraction
            )
            .modifier(SliderViewDefaults())
            .help("Length of the radius as a fraction of the parent ring radius")
            .onChange(of: spriteLayer.spinarmFraction) {
                spriteLayer.spinarmLengthFractionChanged($0)
            }

            SliderView(
                label: "Pen", labellet: "Xr", range: 0.05...0.95, step: 0.1,
                value: $spriteLayer.penLengthFraction
            )
            .modifier(SliderViewDefaults())
            .help("Length of the pen relative to the spin arm")
            .onChange(of: spriteLayer.penLengthFraction) {
                spriteLayer.penLengthFractionChanged($0)
            }
        }
    }
}
