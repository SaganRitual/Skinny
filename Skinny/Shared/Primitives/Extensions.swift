// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

extension CGSize {
    var effectiveRadius: CGFloat { min(width, height) / 2 }
}

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
