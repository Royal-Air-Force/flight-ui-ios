import SwiftUI
import AviationMaths

// MARK: - CoordinateField Validation & Data

extension CoordinateField {

    var segmentInputConfig: InputFieldConfig {
        InputFieldConfig(fontColor: config.fontColor, fontStyle: config.fontStyle,
                         backgroundColor: config.backgroundColor,
                         cornerRadius: config.cornerRadius, borderColor: config.borderColor)
    }

    // MARK: Validation & Assembly

    /// Computes the current latitude from segment state without modifying any stored state.
    func computeLatitude() -> Latitude? {
        switch format {
        case .signedDecimalDegrees:
            return Double(latDecimalDegreesText).flatMap {
                Latitude.isValid(decimalDegrees: $0) ? Latitude(decimalDegrees: $0) : nil
            }
        case .decimalDegrees:
            guard let val = Double(latDecimalDegreesText), val >= 0, val <= 90 else { return nil }
            let signed = latDirection == .north ? val : -val
            return Latitude.isValid(decimalDegrees: signed) ? Latitude(decimalDegrees: signed) : nil
        case .ddm:
            guard let degs = Int(latDegreesText), let mins = Double(latMinutesText),
                  degs >= 0, degs <= 90, mins >= 0, mins < 60 else { return nil }
            let signed = (latDirection == .north ? 1.0 : -1.0) * (Double(degs) + mins / 60.0)
            return Latitude.isValid(decimalDegrees: signed) ? Latitude(decimalDegrees: signed) : nil
        case .dms:
            guard let degs = Int(latDegreesText), let mins = Int(latMinutesText), let secs = Double(latSecondsText),
                  degs >= 0, degs <= 90, mins >= 0, mins < 60, secs >= 0, secs < 60 else { return nil }
            let signed = (latDirection == .north ? 1.0 : -1.0) * (Double(degs) + Double(mins) / 60.0 + secs / 3600.0)
            return Latitude.isValid(decimalDegrees: signed) ? Latitude(decimalDegrees: signed) : nil
        }
    }

    /// Computes the current longitude from segment state without modifying any stored state.
    func computeLongitude() -> Longitude? {
        switch format {
        case .signedDecimalDegrees:
            return Double(lonDecimalDegreesText).flatMap {
                Longitude.isValid(decimalDegrees: $0) ? Longitude(decimalDegrees: $0) : nil
            }
        case .decimalDegrees:
            guard let val = Double(lonDecimalDegreesText), val >= 0, val <= 180 else { return nil }
            let signed = lonDirection == .east ? val : -val
            return Longitude.isValid(decimalDegrees: signed) ? Longitude(decimalDegrees: signed) : nil
        case .ddm:
            guard let degs = Int(lonDegreesText), let mins = Double(lonMinutesText),
                  degs >= 0, degs <= 180, mins >= 0, mins < 60 else { return nil }
            let signed = (lonDirection == .east ? 1.0 : -1.0) * (Double(degs) + mins / 60.0)
            return Longitude.isValid(decimalDegrees: signed) ? Longitude(decimalDegrees: signed) : nil
        case .dms:
            guard let degs = Int(lonDegreesText), let mins = Int(lonMinutesText), let secs = Double(lonSecondsText),
                  degs >= 0, degs <= 180, mins >= 0, mins < 60, secs >= 0, secs < 60 else { return nil }
            let signed = (lonDirection == .east ? 1.0 : -1.0) * (Double(degs) + Double(mins) / 60.0 + secs / 3600.0)
            return Longitude.isValid(decimalDegrees: signed) ? Longitude(decimalDegrees: signed) : nil
        }
    }

    /// Validates both axes from the current segment state and writes the result to the position binding.
    /// Called directly from all segment onChange handlers — no intermediate @State involved.
    /// Only writes when the value actually changes, preventing unnecessary parent re-renders
    /// that can cause Form/List to re-initialise @State.
    func assembleFromCurrentState() {
        guard let lat = computeLatitude(), let lon = computeLongitude() else {
            if position != nil { position = nil }
            return
        }
        let newPosition = Position2D(latitude: lat, longitude: lon)
        if position != newPosition {
            position = newPosition
        }
    }

    // MARK: Population

    func decomposePosition() {
        guard let pos = position else { return }
        populateSegments(from: pos.latitude, lon: pos.longitude)
    }

    func populateSegments() {
        guard let pos = position else { clearSegments(); return }
        populateSegments(from: pos.latitude, lon: pos.longitude)
    }

    func populateSegments(from lat: Latitude, lon: Longitude) {
        // Only update direction from the model when magnitude is non-zero.
        // At exactly 0°, direction is ambiguous — preserve whatever the user has set.
        let updateLatDir = lat.unsignedDecimalDegrees > 0
        let updateLonDir = lon.unsignedDecimalDegrees > 0

        switch format {
        case .signedDecimalDegrees:
            latDecimalDegreesText = String(format: "%.5f", lat.decimalDegrees)
            lonDecimalDegreesText = String(format: "%.5f", lon.decimalDegrees)
        case .decimalDegrees:
            if updateLatDir { latDirection = lat.direction }
            latDecimalDegreesText = String(format: "%.5f", lat.unsignedDecimalDegrees)
            if updateLonDir { lonDirection = lon.direction }
            lonDecimalDegreesText = String(format: "%.5f", lon.unsignedDecimalDegrees)
        case .ddm:
            let latDDM = lat.degreesDecimalMinutes
            if updateLatDir { latDirection = lat.direction }
            latDegreesText = String(latDDM.degrees)
            latMinutesText = String(format: "%.3f", latDDM.minutes)
            let lonDDM = lon.degreesDecimalMinutes
            if updateLonDir { lonDirection = lon.direction }
            lonDegreesText = String(lonDDM.degrees)
            lonMinutesText = String(format: "%.3f", lonDDM.minutes)
        case .dms:
            let latDMS = lat.degreesMinutesSeconds
            if updateLatDir { latDirection = lat.direction }
            latDegreesText = String(latDMS.degrees)
            latMinutesText = String(latDMS.minutes)
            latSecondsText = String(format: "%.\(config.secondsPrecision)f", latDMS.seconds)
            let lonDMS = lon.degreesMinutesSeconds
            if updateLonDir { lonDirection = lon.direction }
            lonDegreesText = String(lonDMS.degrees)
            lonMinutesText = String(lonDMS.minutes)
            lonSecondsText = String(format: "%.\(config.secondsPrecision)f", lonDMS.seconds)
        }
    }

    func clearSegments() {
        latDecimalDegreesText = ""; lonDecimalDegreesText = ""
        latDegreesText = "";        lonDegreesText = ""
        latMinutesText = "";        lonMinutesText = ""
        latSecondsText = "";        lonSecondsText = ""
    }

    // MARK: Preview Strings

    func signedDDString(_ pos: Position2D) -> String {
        String(format: "%.5f°, %.5f°", pos.latitude.decimalDegrees, pos.longitude.decimalDegrees)
    }

    func decimalDDString(_ pos: Position2D) -> String {
        let lat = pos.latitude; let lon = pos.longitude
        return "\(lat.direction.rawValue) \(String(format: "%.5f", lat.unsignedDecimalDegrees))°, "
             + "\(lon.direction.rawValue) \(String(format: "%.5f", lon.unsignedDecimalDegrees))°"
    }

    func ddmString(_ pos: Position2D) -> String {
        let latComp = pos.latitude.degreesDecimalMinutes
        let lonComp = pos.longitude.degreesDecimalMinutes
        return "\(pos.latitude.direction.rawValue) \(latComp.degrees)° \(String(format: "%.3f", latComp.minutes))', "
             + "\(pos.longitude.direction.rawValue) \(lonComp.degrees)° \(String(format: "%.3f", lonComp.minutes))'"
    }

    func dmsString(_ pos: Position2D) -> String {
        let latComp = pos.latitude.degreesMinutesSeconds
        let lonComp = pos.longitude.degreesMinutesSeconds
        let fmt = "%.\(config.secondsPrecision)f"
        return "\(pos.latitude.direction.rawValue) \(latComp.degrees)° \(latComp.minutes)' "
             + "\(String(format: fmt, latComp.seconds))\", "
             + "\(pos.longitude.direction.rawValue) \(lonComp.degrees)° \(lonComp.minutes)' "
             + "\(String(format: fmt, lonComp.seconds))\""
    }

    // MARK: Segment Alerting States

    var latDDState: InputAlertingState {
        let limit: ClosedRange<Double> = format == .signedDecimalDegrees ? -90...90 : 0...90
        return segmentState(text: latDecimalDegreesText, parse: Double.init, range: limit)
    }

    var lonDDState: InputAlertingState {
        let limit: ClosedRange<Double> = format == .signedDecimalDegrees ? -180...180 : 0...180
        return segmentState(text: lonDecimalDegreesText, parse: Double.init, range: limit)
    }

    var latDegreesState: InputAlertingState { segmentState(text: latDegreesText, parse: Int.init, range: 0...90) }
    var lonDegreesState: InputAlertingState { segmentState(text: lonDegreesText, parse: Int.init, range: 0...180) }
    var latMinDecState: InputAlertingState { segmentState(text: latMinutesText, parse: Double.init, range: 0.0..<60.0) }
    var lonMinDecState: InputAlertingState { segmentState(text: lonMinutesText, parse: Double.init, range: 0.0..<60.0) }
    var latMinIntState: InputAlertingState { segmentState(text: latMinutesText, parse: Int.init, range: 0..<60) }
    var lonMinIntState: InputAlertingState { segmentState(text: lonMinutesText, parse: Int.init, range: 0..<60) }
    var latSecondsState: InputAlertingState { segmentState(text: latSecondsText, parse: Double.init, range: 0.0..<60.0) }
    var lonSecondsState: InputAlertingState { segmentState(text: lonSecondsText, parse: Double.init, range: 0.0..<60.0) }

    private func segmentState<T: Comparable, R: RangeExpression>(
        text: String, parse: (String) -> T?, range: R
    ) -> InputAlertingState where R.Bound == T {
        guard !text.isEmpty, let val = parse(text) else { return alertingState }
        return range.contains(val) ? alertingState : .warning
    }
}
