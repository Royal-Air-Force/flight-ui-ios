# FlightUI

## Background

FlightUI is a [Swift Package](https://developer.apple.com/documentation/xcode/swift-packages) that enables apps used by aircrew in-flight to be developed more quickly using a reusable, well-tested set of UI components and assets. Current in-flight apps include Ballistic v4 and Tanker.

FlightUI is currently in the early stages of development.

## Components and Assets

The list of components and assets is currently small and will grow over time but includes buttons, typography and colours.

## Testing

We will use [ViewInspector](https://github.com/nalexn/ViewInspector) to develop UI-focused component tests. Apps assembled using FlightUI will continue to use Xcode UI tests running on a Simulator or physical device. (Apps may also have their own need to use ViewInspector but this is not required to consume FlightUI components).

## License

FlightUI is available under the MIT license. See the LICENSE file for more info.