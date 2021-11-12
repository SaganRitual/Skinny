// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ContentView: View {
    static private let size = CGSize(width: 400, height: 400)
    static let sceneRadius = size.width / 2

    @StateObject var arenaScene = ArenaScene(size: ContentView.size)

    func getSmallSide(from size: CGSize) -> CGFloat {
        size.width > size.height ? size.height : size.width
    }

    var body: some View {
//        GeometryReader { gr in
            HStack {
                VStack {
                    AppSettingsView()
                    if !$arenaScene.layerStack.layers.isEmpty {
                        LayerSettingsListView()
                    }
                }
                .frame(width: 300)

                ArenaView()
//                    .frame(
//                        width: getSmallSide(from: gr.size),
//                        height: getSmallSide(from: gr.size),
//                        alignment: .topTrailing
//                    )
//                    .frame(width: 600, height: 600)
            }
            .environmentObject(arenaScene)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
