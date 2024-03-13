//
//  DemonstrationViewModel.swift
//  Kitchen Sink
//
//  Created by Jake Dove on 11/03/2024.
//

import Foundation
import Combine

class DemonstrationViewModel : ObservableObject {

    // Properties to hold input values from text fields
    @Published var kgInputString: String = "0"
    @Published var lbsInputString: String = "0"

    let kgHint = "Enter Kgs"
    let lbHint = "Enter Lgs"
    let conversionRate: Double = 2.205


    var kgDouble: Double {
        if let kgDouble = Double(kgInputString) {
            print("Kgs as a string " + String(kgDouble))
            return kgDouble
        } else {
            print("returning Kgs  0.0")
            return 0.0 // Return nil if the input string cannot be converted to a valid Double
        }
    }


    var lbDouble: Double {
        if let lbsValue = Double(lbsInputString) {
            print("lbs as a string " + String(lbsValue))
            return lbsValue
        } else {
            print("returning 0.0")
            return 0.0 // Return nil if the input string cannot be converted to a valid Double
        }
    }

    func updatelbInput() {
        // Perform conversion from lbs to kg
        lbsInputString = String (format: "%.2f",convertKgsToLbs(kgs: kgDouble))
    }

    func updateKgInput() {
        // Perform conversion from lbs to kg
        kgInputString = String (format: "%.2f", convertLbsToKg(lbs: lbDouble))
    }

    func convertKgsToLbs(kgs: Double) -> Double {
        var int = kgs * conversionRate
        print ("converted string " + String(int))
        return (kgs * conversionRate)
    }

    func convertLbsToKg(lbs: Double) -> Double {
        var int = lbs / conversionRate
        print ("converted string " + String(int))
        return (lbs / conversionRate)
    }

    func runWeightConversion(isSwapped: Bool) {
        if (isSwapped) {
            print("converting from Kgs to Lbs")
           updatelbInput()
        }else {
            print("converting from Lbs to Kgs")
            updateKgInput()
        }
    }
}
