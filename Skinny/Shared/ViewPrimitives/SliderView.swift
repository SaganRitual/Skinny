// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SliderView: View {
    let label: String
    let range: ClosedRange<Double>
    let step: Double

    @Binding var value: Double

    let pub = NotificationCenter.default
                .publisher(for: NSNotification.Name("ringRadius"))

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 75, height: nil, alignment: .leading)
                .padding(.leading)

            Slider(
                value: $value,
                in: range,
                step: step,
                minimumValueLabel: Text("\(range.lowerBound.asString(decimals: 0))"),
                maximumValueLabel: Text("\(range.upperBound.asString(decimals: 0))"),
                label: { }
            )
            .padding(.trailing, 10)
        }
    }
}

struct AppSettingsSliderView_Previews: PreviewProvider {
    @State static var ring0SpinPeriod = 0.0

    static var previews: some View {
        SliderView(
            label: "Zoom",
            range: 1...10, step: 1,
            value: $ring0SpinPeriod
        )
    }
}
