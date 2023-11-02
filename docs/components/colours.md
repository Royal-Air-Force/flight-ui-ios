# 🎨 Colours

Unlike most applications, FlightUI does not provide a branding or specific theming colour, instead the goal is to provide a very neutral palette for most user interactions with colours being given very specific contexts based on the Society of Flight Test Engineers: Guidelines for Displays documentation.

These contexts are; Advisory, Nominal, Caution, and Warning.

In addition to these contexts, the library also provides colours for backgrounds, surfaces and content, supporting both a light and dark mode, as well as a series of colours to be used in graphics such as charts or diagrams.

## 👁️ Accessibility

Despite accessibility in colours typically being thought of as something intended for users with poor eyesight or for highly limited devices, something that typically doesn't overlap with pilots and modern mobile devices, it has been a critical part of the development of FlightUI.

Firstly, this library isn't intended for exclusive use by pilots and there may be other use cases such as back office staff, mission planners, or support personnel who may be using the applications developed with these design tools.

Secondly, the key to colour accessibility is contrast and ensuring that content on screen is clearly visible and easy to distinguish. In high pressure situations, this may become extremely vital to convey clear and accurate information, particually in a glanceable manner for users.

All colours provided within this library meet at least the AA minimum contrast ratio for normal text on all three of the background colours (background, surface low, and surface high). Many of the colours also support AAA enhanced contrast compliance. When using this library as expected, with the standard backgrounds and defined content colours, you can be assured that your application will meet AA compliance under the Web Content Accessibility Guidelines (WCAG).

A table has been provided [below](#👀-colour-accessibility-table) and for more information on the WCAG, see the [Web Accessibility Initiative](https://www.w3.org/WAI/standards-guidelines/wcag/) website.

## 🤩 Avoiding Halation Effect

The [halation effect](https://www.dictionary.com/browse/halation) originally came from film and media, but generally can be defined as the effect caused by the spreading of light beyond it's proper boundaries to form a fog around the edges of a bright image.

You have likely experienced this yourself either in film or just when working with screens, placing full white (#FFFFFF) text on a full black (#000000) background can sometimes look like the white colour is bleeding into the background. This is due to the way [white light is scattering](https://uxmovement.com/content/when-to-use-white-text-on-a-dark-background/) and can make the shape of words and letters harder to perceive, affecting readability and increasing eye strain.

To avoid this, full black has been avoided as a colour within FlightUI, opting for either dark or light greys as required. This also has the added benefit of avoiding black smearing on OLED devices where pixels are turned on and off, while still having a very low power per pixel consumption.

## 1️⃣ General Colour Usage
General colours is the name of the group of colours used to distinguish content and content areas within the application.

- **Background** -  Default colour for every screen background
- **Surface Low** - Background colour for structural components such as cards and bottom sheets
- **Surface High** - Colour for component surfaces closer to the user such as text fields and alert dialogs
- **Primary** - Default colour for all content including text, icons, and non-context based components. Also acts as the Advisory colour for the theme.
- **Secondary** - Colour with lower priority for content, such as subtitles or unselected components
- **Disabled** - Colour for all disabled components including button backgrounds, input field backgrounds, etc.
- **On Disabled** - Colour for disabled content on top of a disabled component, for example the text shown on a disabled button

## 2️⃣ Core Colour Usage
Core colours is the name of the group of colours used to bring context to an app such as indicating user input or success state. It matches the naming scheme and use cases from the context colours within the Society of Flight Test Engineers: Guidelines for Displays documentation.

- **Input Output** - Colour used to indicate required input or output for a user
- **Nominal** - Colour to indicate a general success or safe action such as proceeding in a flow
- **Caution** - Colour to indicate a non-severe warning, such as continuing with data input that is technically valid but requires expertise and confirmation
- **Warning** - Colour to be used very sparingly, and indicates a severe or potential risk to life error within it's use case

## 3️⃣ Graphics Colour Usage
Graphics colours is the name of the group of colours that are only to be used for displaying complex data sets such as graphs and diagrams.

These colours should not be used for any other forms of content and are intentionally very limited in their use case. While several colour shades are visually fairly close together, when creating graphs and diagrams designers and developers should be very mindful about minimising the use of similar shades. A line graph with two lines using the Graphics Cyan and Graphics Blue colours for example would not be very clear and distinguishable to users.

## 👀 Colour Accessibility Table
### Dark Theme
| Colour | Hex Code | On Background | On Surface Low | On Surface High | Notes |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| Primary | #F0F0F0 | ✅ AAA Pass | ✅ AAA Pass | ✅ AAA Pass | - |
| Secondary | #D0D0D0 | ✅ AAA Pass | ✅ AAA Pass | ✅ AAA Pass | - |
| Input Output | #F0F0F0 | ✅ AAA Pass | ✅ AAA Pass | ✅ AAA Pass | - |
| Nominal | #64D2FF | ✅ AAA Pass | ✅ AAA Pass | ✅ AAA Pass | - |
| Caution | #30D158 | ✅ AAA Pass | ✅ AAA Pass | ✅ AAA Pass | - |
| Warning | #FF3429 | ✔ AA Pass | ✔ AA Pass | ✔ AA Pass | AAA for large text and graphics |
| Graphics | - | ✔ AA Pass | ✔ AA Pass | ✔ AA Pass | Lighter colours pass AAA but darker shades may be AA |

### Light Theme
| Colour | Hex Code | On Background | On Surface Low | On Surface High | Notes |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| Primary | #050505 | ✅ AAA Pass | ✅ AAA Pass | ✅ AAA Pass | - |
| Secondary | #515151 | ✅ AAA Pass | ✅ AAA Pass | ✅ AAA Pass | - |
| Input Output | #0075A3 | ✔ AA Pass | ✔ AA Pass | ✔ AA Pass | AAA for large text and graphics |
| Nominal | #1B7E34 | ✔ AA Pass | ✔ AA Pass | ✔ AA Pass | AAA for large text and graphics |
| Caution | #806A00 | ✔ AA Pass | ✔ AA Pass | ✔ AA Pass | AAA for large text and graphics |
| Warning | #DB0B00 | ✔ AA Pass | ✔ AA Pass | ✔ AA Pass | AAA for large text and graphics |
| Graphics | - | ✔ AA Pass | ✔ AA Pass | ✔ AA Pass | Lighter colours pass AAA but darker shades may be AA |