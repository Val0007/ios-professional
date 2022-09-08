//
//  DecimalUtil.swift
//  Bankey
//
//  Created by Val V on 08/09/22.
//

import Foundation
extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
