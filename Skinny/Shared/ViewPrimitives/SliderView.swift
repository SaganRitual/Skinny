// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SliderViewDefaults: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.trailing, 10)
            .controlSize(.small)
            .monospacedDigit()
            .allowsTightening(false)
            .minimumScaleFactor(1)
            .lineLimit(1)
    }
}

struct SliderView: View {
    let label: String
    let labellet: String
    let range: ClosedRange<Double>
    let step: Double

    @Binding var value: Double

    var body: some View {
        VStack {
            Slider(
                value: $value,
                in: range,
                step: step,
                minimumValueLabel: Text("\(range.lowerBound.asString(decimals: 2))"),
                maximumValueLabel: Text("\(range.upperBound.asString(decimals: 2))"),
                label: { }
            )
            .padding([.leading, .trailing], 10)

            HStack {
                Text(label)
                    .frame(alignment: .leading)

                Text("\(value.asString(decimals: 2))\(labellet)")
                    .frame(alignment: .trailing)
            }
        }
        .padding(.bottom, 10)
        .border(SeparatorShapeStyle(), width: 5)
        .padding(.bottom, -8)
    }
}

struct AppSettingsSliderView_Previews: PreviewProvider {
    @State static var ring0SpinPeriod = 0.0

    static var previews: some View {
        SliderView(
            label: "Zoom", labellet: "X",
            range: 1...10, step: 1,
            value: $ring0SpinPeriod
        )
    }
}
