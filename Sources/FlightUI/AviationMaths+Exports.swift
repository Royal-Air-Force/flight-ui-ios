// AviationMaths is a direct dependency of FlightUI.
// Each component file that uses AviationMaths types imports it explicitly.
// Host apps that bind to Latitude, Longitude, or Position2D should add
// AviationMaths as their own dependency — SwiftPM deduplicates it automatically,
// so there is no version conflict when both FlightUI and the host app declare it.
import AviationMaths
