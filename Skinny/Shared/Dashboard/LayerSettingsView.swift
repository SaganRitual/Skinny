// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct LayerSettingsView: View {
    var body: some View {
        VStack {
            LayerSlidersGroupView()
            LayerToggleGroupView()
        }
    }
}

struct LayerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LayerSettingsView()
    }
}
