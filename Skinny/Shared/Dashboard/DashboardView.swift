// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var arenaScene: ArenaScene

    @State var carouselHz = 0.0
    @State var driveRateHz = 1.0
    @State var runSpeed = 1.0
    @State var zoomLevel = 1.0

    static let pathFadeDurationSeconds = CGFloat(5)

    var body: some View {
        VStack {
            HStack {
                SliderView(
                    label: "Carousel", labellet: "Hz", range: -5...5, step: 1,
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
            }

            HStack {
                SliderView(
                    label: "Drive rate", labellet: "Hz", range: -5...5, step: 1,
                    value: $driveRateHz
                )
                .padding(.trailing, 10)
                .controlSize(.small)
                .monospacedDigit()
                .allowsTightening(false)
                .minimumScaleFactor(1)
                .lineLimit(1)
                .help("Orbit rate of the first inner ring; drives all the movement")
                .onChange(of: driveRateHz) { arenaScene.setDriveRate(X: $0) }
            }

            HStack {
                SliderView(
                    label: "Speed", labellet: "X", range: 0...10, step: 1,
                    value: $runSpeed
                )
                .padding(.trailing, 10)
                .controlSize(.small)
                .monospacedDigit()
                .allowsTightening(false)
                .minimumScaleFactor(1)
                .lineLimit(1)
                .help("Ratio of run time to wall time")
                .onChange(of: runSpeed) { arenaScene.setRunSpeed(X: $0) }
            }

            HStack {
                SliderView(label: "Zoom", labellet: "X", range: 0.5...10,
                           step: 0.5, value: $zoomLevel
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
}
