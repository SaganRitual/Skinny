// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ArenaView: View {
    @EnvironmentObject var arenaScene: ArenaScene

    var body: some View {
        SpriteView(scene: arenaScene).scaledToFill()
    }
}

struct ArenaView_Previews: PreviewProvider {
    static var previews: some View {
        ArenaView()
    }
}
