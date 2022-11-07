# Toasty: A SwiftUI Toast Package
Present custom alerts, toasts, and banners in pure-SwiftUI.

<p align="center">
   <img src="https://github.com/elai950/AlertToast/blob/master/Assets/GithubCoverNew.png" width="480"/>
</p>

## 🍞 Example

<p align="center">
    <img src="https://github.com/elai950/AlertToast/blob/master/Assets/onboarding.png" style="display: block; margin: auto;"/>
</p>

<p align="center">
    <img src="https://github.com/elai950/AlertToast/blob/master/Assets/ToastExample.gif" style="display: block; margin: auto;" width="180"/>
</p>

## 🔭 Overview
Toasty allows you to design and present unobtrusive status updates inside your app (colloquially known as "toasts" ) that don't require any user action to dismiss or to validate. Common uses include things like: `Message Sent`, `Poor Network Connection`, `Profile Updated`, `Logged In/Out`, `Favorited`, `Loading`, etc.

<img src="https://img.shields.io/badge/BUILD-1.3.7-green?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/PLATFORM-IOS%20|%20MACOS-lightgray?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/LICENSE-MIT-lightgray?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/MADE WITH-SWIFTUI-orange?style=for-the-badge" />

- Built entirely in SwiftUI
- Includes 3 out of the box display modes:
  - `Alert`: Pops a square toast in the center of the screen (similar to the Apple Music "Added to Library" overlays)
  - `HUD`: Drops a rounded capsule from the top of the screen (similar to the system "AirPods connected" overlays)
  - `Banner`: Slides a rounded rectangular banner up from the bottom of the screen (similar to the Instagram "No Connection" overlays)
- Includes 6 flexible styling options:
  - `Complete`: an animated checkmark
  - `Error`: an animated xmark
  - `SystemImage`: a system icon
  - `Image`: your own custom image
  - `Loading`: a spinning progress indicator
  - `Regular`: just good ol' title and subtitle only
* Supports Light & Dark Mode
* Works with **any** kind of view builder.
* Localization support
* Customize just about any aspect of your toast (font, color, background, etc.)

## 💻 Installation

### Swift Package Manager
The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `Toasty` into your Xcode project add the following dependency

```ogdl
https://github.com/nenosllc/Toasty.git, :branch="master"
```

### Manually
If you prefer not to use any of dependency managers, you can integrate `AlertToast` into your project manually. Put `Sources/AlertToast` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## 🧳 Requirements

- iOS 14.0+ | macOS 12+
- Xcode 13.0+ | Swift 5.5+

## 🛠 Usage
`import Toasty` everywhere you would like to use `Toasty`. Then, use the `.toast` view modifier:

**Parameters:**

- `isPresenting` [required]: assign a `Binding<Bool>` to show or dismiss alert.
- `duration`: default is 2, set 0 to disable auto dismiss.
- `tapToDismiss`: default is `true`, set `false` to disable.
- `alert` [required]: expects an `AlertToast` view.

#### Regular Alert Example

```swift 
import SwiftUI
import Toasty

struct ContentView: View {

    @State private var showToast = false

    var body: some View {
        VStack {
            Button("Show Toast") {
                 showToast.toggle()
            }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(type: .regular, title: "Message Sent!")
        }
    }
}
```

#### Complete Modifier Example

```swift
.toast(isPresenting: $showAlert, duration: 2, tapToDismiss: true, alert: {
   // AlertToast goes here
}, onTap: {
   // If tapToDismiss is true, onTap is called and then dismiss the alert.
}, completion: {
   // Completion block called after dismiss
})
```

### Alert Toast Initializer

```swift
AlertToast(
    displayMode: DisplayMode,
    type: AlertType,
    title: Optional(String),
    subTitle: Optional(String),
    style: Optional(AlertStyle)
)
```

### Alert Style Initializer

```swift
AlertStyle(
    backgroundColor: Color?,
    titleColor: Color?,
    subTitleColor: Color?,
    titleFont: Font?,
    subTitleFont: Font?
)
```

### Available Alert Types

- **Regular:** text only (title and subtitle).
- **Complete:** animated checkmark.
- **Error:** animated xmark.
- **System Image:** system image from `SFSymbols`.
- **Image:** named image from your assets catalog.
- **Loading:** circular progress indicator.

Alert dialog view modifier (with default settings)
```swift
.toast(isPresenting: Binding<Bool>, duration: Double = 2, tapToDismiss: true, alert: () -> AlertToast , onTap: () -> (), completion: () -> () )
```

Simple Text Alert:
```swift
AlertToast(type: .regular, title: Optional(String), subTitle: Optional(String))
```

Complete / Error Alert:
```swift
AlertToast(type: .complete(Color)/.error(Color), title: Optional(String), subTitle: Optional(String))
```

System Image Alert:
```swift
AlertToast(type: .systemImage(String, Color), title: Optional(String), subTitle: Optional(String))
```

Image Alert:
```swift
AlertToast(type: .image(String), title: Optional(String), subTitle: Optional(String))
```

Loading Alert:
```swift
// When using loading, duration won't auto dismiss and tapToDismiss is set to false
AlertToast(type: .loading, title: Optional(String), subTitle: Optional(String))
```

**Note: you can add multiple `.toast` modifiers to a single view.**

## 📖 Documentation
You can take a look at the original article which inspired this library on Medium: [How to present a toast alert in SwiftUI](https://elaizuberman.medium.com/presenting-apples-music-alerts-in-swiftui-7f5c32cebed6). There is additional inline documentation you can refer to as well. From the Xcode menu, select Product > Build Documentation.

## 👨‍💻 Contributors
All issue reports, feature requests, pull requests and GitHub stars are welcomed and much appreciated.

- [@barnard-b](https://github.com/barnard-b)
- [@Sam-Spencer](https://github.com/Sam-Spencer)

## ✍️ Original Author
This fork is based on the original library from [Elai Zuberman](https://github.com/elai950).

## 📃 License
`Toasty` is available under the MIT license. See the [LICENSE](https://github.com/elai950/AlertToast/blob/master/LICENSE.md) file for more info.

---

- [Jump to Overview](#-overview)
