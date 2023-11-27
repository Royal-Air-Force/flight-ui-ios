//
//  String+Extensions.swift
//  Flight UI - Kitchen Sink Sample
//
//  Created by Appivate 2023
//

extension String {
    var isEmptyTrimmed: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
