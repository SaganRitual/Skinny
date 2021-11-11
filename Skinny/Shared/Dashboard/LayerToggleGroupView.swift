// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct LayerToggleGroupView: View {
    @EnvironmentObject var spriteLayer: SpriteLayer

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ToggleView(isChecked: $spriteLayer.showPen, label: "Pen")
                ToggleView(isChecked: $spriteLayer.showRadius, label: "Radius")
            }
            .frame(width: 100)

            VStack(alignment: .leading) {
                ToggleView(isChecked: $spriteLayer.showCenters, label: "Centers")
                ToggleView(isChecked: $spriteLayer.showRing, label: "Ring")
            }
            .frame(width: 100)
        }
    }
}
