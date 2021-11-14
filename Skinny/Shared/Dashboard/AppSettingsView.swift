// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var arenaScene: ArenaScene

    @State var carouselHz = UserDefaults.standard.double(forKey: "carouselHz")
    @State var driveRateHz = UserDefaults.standard.double(forKey: "driveRateHz")
    @State var runSpeed = UserDefaults.standard.double(forKey: "runSpeed")
    @State var zoomLevel = UserDefaults.standard.double(forKey: "zoomLevel")

    static let pathFadeDurationSeconds = CGFloat(15)

    static let driveRateRange = -1.5...1.5
    static let simSpeedRange = 0.0...2.0

    var body: some View {
        VStack {
            SliderView(
                label: "Carousel", labellet: "Hz", range: -1.5...1.5, step: 0.25,
                value: $carouselHz
            )
            .modifier(SliderViewDefaults())
            .help("Spin rate of the base ring backward/forward; changes shape of the plot")
            .onChange(of: carouselHz) { arenaScene.setCarousel($0) }

            SliderView(
                label: "Drive rate", labellet: "Hz",
                range: AppSettingsView.driveRateRange, step: 0.25,
                value: $driveRateHz
            )
            .modifier(SliderViewDefaults())
            .help("Orbit rate of the first inner ring; drives all the movement")
            .onAppear(perform: {
                let hi = min(AppSettingsView.driveRateRange.upperBound, self.driveRateHz)
                let adjusted = max(AppSettingsView.driveRateRange.lowerBound, hi)
                self.driveRateHz = adjusted

                UserDefaults.standard.set(self.driveRateHz, forKey: "driveRateHz")

                self.arenaScene.driveRateShadow = self.driveRateHz
            })
            .onChange(of: driveRateHz) { newRate in self.setDriveRate(newRate) }

            SliderView(
                label: "Speed", labellet: "X", range: 0...2, step: 0.25,
                value: $runSpeed
            )
            .modifier(SliderViewDefaults())
            .help("Ratio of run time to wall time")
            .onAppear(perform: {
                let hi = min(AppSettingsView.simSpeedRange.upperBound, self.runSpeed)
                let adjusted = max(AppSettingsView.simSpeedRange.lowerBound, hi)
                self.runSpeed = adjusted

                UserDefaults.standard.set(adjusted, forKey: "runSpeed")
                self.setRunSpeed(adjusted)
            })
            .onChange(of: runSpeed) { self.setRunSpeed($0) }

            SliderView(label: "Zoom", labellet: "X", range: 0...3,
                       step: 0.25, value: $zoomLevel
            )
            .modifier(SliderViewDefaults())
            .help("Zoom, like it says on the tin")
            .onAppear { arenaScene.setViewingScale(X: zoomLevel) }
            .onChange(of: zoomLevel) { arenaScene.setViewingScale(X: $0) }
        }
    }
}

extension AppSettingsView {
    func setDriveRate(_ driveRateHz: Double) {
        UserDefaults.standard.set(driveRateHz, forKey: "driveRateHz")

        let current = arenaScene.driveRateShadow
        let new = driveRateHz
        let delta = new - current

        if delta == 0 { return }

        let changeAction = SKAction.customAction(withDuration: 1) { _, completionFraction in
            arenaScene.driveRateShadow = current + completionFraction * delta
        }

        arenaScene.removeAllActions()
        arenaScene.run(changeAction) {
            self.arenaScene.driveRateShadow = self.driveRateHz
        }
    }

    func setRunSpeed(_ runSpeed: Double) {
        UserDefaults.standard.set(runSpeed, forKey: "runSpeed")
        self.arenaScene.speed = runSpeed
        self.arenaScene.runSpeedShadow = runSpeed
    }
}
