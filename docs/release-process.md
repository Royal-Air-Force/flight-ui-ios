# 🚀 Project Releases

## 🗓️ Release Schedule
Releases are performed on an ad hoc basis, there is no explicit heartbeat release cycle that this project is aiming to achieve. 

## 🧐 Linting
This project uses [SwiftLint](https://github.com/realm/SwiftLint) in order to enforce Swift style and conventions. These are loosly based off the GitHub Swift Style guide and are well described in popular and common style guides such as Kodeco's Swift Style Guide.

SwiftLint enforces the style guide rules that are generally accepted by the Swift community and should be adhered to in this project. The pipeline will provide warnings if you introduce any Swift lint warnings into a pull request, and it may be requested that you fix these issues before your PR will be accepted.

## 🧪 Testing
We will use [ViewInspector](https://github.com/nalexn/ViewInspector) to develop UI-focused component tests. Apps assembled using FlightUI will continue to use Xcode UI tests running on a Simulator or physical device. (Apps may also have their own need to use ViewInspector but this is not required to consume FlightUI components).

## 🔢 Versioning
This project uses [SemVer](https://semver.org/) or Semantic Versioning, in order to manage version numbers. This follows the convention of the `MAJOR.MINOR.PATCH` style where;
- MAJOR version changes when there is an incompatible API change
- MINOR version changes when functionality is added in a backward compatible manner
- PATCH version changes when there are backward compatible bug fixes or improvements

## 🚀 Deployment
The release of a new version of the FlightUI library is managed through the use of Git Tags, where a new Git Tag is pushed to `main` referencing a commit up to date with that expected version. The Git Tag itself is named with the current version of the library (see Versioning above) and will then be available for updating within Xcode projects.

In addition to a tag, a 'GitHub Release' should also be made with every deployment of the library, this release should document the changes included and also provide information for any necessary migration that implementing applications may need to perform.