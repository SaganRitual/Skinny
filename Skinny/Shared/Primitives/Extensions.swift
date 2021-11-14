// We are a way for the cosmos to know itself. -- C. Sagan

import CoreGraphics

extension CGFloat {
    static let tau = CGFloat.pi * 2
}

extension Double {
    static let tau = Double.pi * 2

    func asString(decimals: Int) -> String {
        let format = String(format: "%%.0\(decimals)f")
        return String(format: format, self)
    }
}


// 🙏
// https://gist.github.com/backslash-f/487f2b046b1e94b2f6291ca7c7cd9064
extension ClosedRange {
    func clamp(_ value: Bound) -> Bound {
        return lowerBound > value ? self.lowerBound
            : upperBound < value ? self.upperBound
            : value
    }
}
