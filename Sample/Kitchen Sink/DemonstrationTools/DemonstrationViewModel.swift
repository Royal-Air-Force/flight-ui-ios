//
//  DemonstrationViewModel.swift
//  Kitchen Sink
//
//  Created by Jake Dove on 11/03/2024.
//

import Foundation

class DemonstrationViewModel : ObservableObject {

    @Published var kgInput = ""
    @Published var lbsInput = ""

    let kgHint = "Enter Kgs"
    let lbHint = "Enter Lgs"


}
