//
//  UnboundSelectionEnum.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

public protocol UnboundSelectionEnum: CaseIterable, CustomStringConvertible {

    static func custom(string: String) -> Self

}
