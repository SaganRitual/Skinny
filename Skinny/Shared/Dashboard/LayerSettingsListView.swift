// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct LayerSettingsListView: View {
    @EnvironmentObject var arenaScene: ArenaScene

    var body: some View {
        List(arenaScene.layers, id: \.id) { layerSettings in
            LayerSettingsView().environmentObject(layerSettings)
        }
    }
}

struct LayerSettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        LayerSettingsListView()
    }
}
