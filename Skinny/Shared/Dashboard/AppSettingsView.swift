// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var arenaScene: ArenaScene

    @State var carouselHz = 0.0
    @State var driveRateHz = 1.0
    @State var runSpeed = 0.1
    @State var zoomLevel = 1.0

    static let pathFadeDurationSeconds = CGFloat(15)

    var body: some View {
        VStack {
            SliderView(
                label: "Carousel", labellet: "Hz", range: -1.5...1.5, step: 0.1,
                value: $carouselHz
            )
            .padding(.trailing, 10)
            .controlSize(.small)
            .monospacedDigit()
            .allowsTightening(false)
            .minimumScaleFactor(1)
            .lineLimit(1)
            .help("Spin rate of the base ring backward/forward; changes shape of the plot")
            .onChange(of: carouselHz) { arenaScene.setCarousel($0) }

            SliderView(
                label: "Drive rate", labellet: "Hz", range: -1.5...1.5, step: 0.1,
                value: $driveRateHz
            )
            .padding(.trailing, 10)
            .controlSize(.small)
            .monospacedDigit()
            .allowsTightening(false)
            .minimumScaleFactor(1)
            .lineLimit(1)
            .help("Orbit rate of the first inner ring; drives all the movement")
            .onChange(of: driveRateHz) { arenaScene.setDriveRate($0) }

            SliderView(
                label: "Speed", labellet: "X", range: 0...2, step: 0.05,
                value: $runSpeed
            )
            .padding(.trailing, 10)
            .controlSize(.small)
            .monospacedDigit()
            .allowsTightening(false)
            .minimumScaleFactor(1)
            .lineLimit(1)
            .help("Ratio of run time to wall time")
            .onAppear { arenaScene.setRunSpeed(X: runSpeed) }
            .onChange(of: runSpeed) { arenaScene.setRunSpeed(X: $0) }

            SliderView(label: "Zoom", labellet: "X", range: 0...3,
                       step: 0.1, value: $zoomLevel
            )
            .padding(.trailing, 10)
            .controlSize(.small)
            .monospacedDigit()
            .allowsTightening(false)
            .minimumScaleFactor(1)
            .lineLimit(1)
            .help("Zoom, like it says on the tin")
            .onAppear { arenaScene.setViewingScale(X: zoomLevel) }
            .onChange(of: zoomLevel) { arenaScene.setViewingScale(X: $0) }
        }
    }
}
