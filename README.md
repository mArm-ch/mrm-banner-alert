# MRMBannerAlert

<img align="left" alt="Version : 1.0.0" src="https://img.shields.io/badge/Version-1.0.0-lightblue.svg" /> <img align="left" alt="Swift : 5" src="https://img.shields.io/badge/Swift-5-blue.svg" /> <img align="left" alt="Licence : MIT" src="https://img.shields.io/badge/Licence-MIT-blue.svg" /> <img align="left" alt="Files : 3" src="https://img.shields.io/badge/Files-3-blue.svg" />
<br /><br />

## Introduction

MRMBannerAlert is Aa simple, easy-to-use iOS banner alert that can be displayed in multiple positions and directions. <br />
It's Swift made and is provided with pre-defined themes, and is fully customizable.

### :blue_car: Roadmap
- [X] Infinite display time
- [X] Hide on click
- [ ] Possibility to choose the popout direction
- [ ] Add fadein/fadeout
- [ ] More themes
- [ ] Gradient backgrounds

## :notebook: How to use (basic)

1. Import the file from `./mrm-banner-alert/MRMBannerAlert/MRMBannerAlert/MRMBannerAlert.swift`
2. Call the ```show()``` static method :
```swift
@IBAction func showBannerAlert(_ sender: Any?) {
        MRMBannerAlert.show(title: "Banner title",
                            message: "Banner multiline text",
                            start: .top)
}
```

## :notebook_with_decorative_cover: How to use (extended)

1. Import the file from `./mrm-banner-alert/MRMBannerAlert/MRMBannerAlert/MRMBannerAlert.swift`
2. Create a `MRMBannerAlertConfig` object to customize your alert 
```swift
var config = MRMBannerAlertConfig()
```
3. Customize some properties 
```swift
config.titleColor = .white
config.messageColor = .white
config.backgroundColor = .red
config.alertDuration = 3.0 
```
4. Create a new `MRMBannerAlert` object, and pass it your custom config
```swift
let banner = MRMBannerAlert(title: "Demo Alert", 
                            message: "This is the bannert alert text", 
                            start: .top, 
                            config: config)
```
5. Finaly, show the banner
```swift
banner.show(in: theParentControllerToDisplayIn, 
            didShowCallback: OptionalClosure, 
            didHideCallback: OptionalClosure)
```

## :wrench: Configuration
You can customize the layout of the banner by instantiate a config object and customize it.

| Property      | Type          | Default value | Description    | 
| ------------- | ------------- | ------------- | ------------- |
| titleColor  | `UIColor`  | `.black`  |    |
| titleFont  | `UIFont`  | `.boldSystemFont(ofSize: 17.0)`  |    |
| titleAlignment  | `NSTextAlignment`  | `.left`  |    |
| messageColor  | `UIColor`  | `.black`  |    |
| messageFont  | `UIFont`  | `.systemFont(ofSize: 16.0)`  |    |
| messageAlignment  | `NSTextAlignment`  | `.left`  |    |
| backgroundColor  | `UIColor`  | `.white`  |    |
| shadowColor  | `UIColor`  | `.gray`  |    |
| shadowOpacity  | `Float`  | `0.3`  |    |
| shadowOffset  | `CGSize`  | `CGSize(width: 6.0, height: 6.0)`  |    |
| shadowRadius  | `CGFloat`  | `0.5`  |    |
| borderWidth  | `CGFloat`  | `1.0`  |    |
| borderColor  | `UIColor`  | `.darkGray`  |    |
| cornerRadius  | `Double`  | `8.0`  |    |
| margin  | `Double`  | `12.0`  | Margin **outside** the banner   |
| padding  | `Double`  | `8.0`  | Padding **inside** the banner   |
| popinDuration  | `TimeInterval`  | `0.5`  | Time the banner takes to display   |
| popinAnimation  | `UIView.AnimationOptions`  | `.curveEaseIn`  |    |
| popoutDuration  | `TimeInterval`  | `0.5`  | Time the banner takes to hide   |
| popoutAnimation  | `UIView.AnimationOptions`  | `.curveEaseOut`  |    |
| alertDuration  | `TimeInterval`  | `2.0`  | Time the banner is displayed   |

## :art: Themes
There are pre-configured themes already available in the banner config. <br />
You can use it by initializing a configuration object : 
```swift
let config = MRMBannerAlertConfig.themed(.white_darkGray)
```

### Themes available 
```swift
/// White background with dark gray texts
case white_darkGray
/// White background with gray texts
case white_gray
/// White background with light gray texts
case white_lightGray
/// Dark gray background with white texts
case darkGray_white
/// Gray background with white texts
case gray_white
/// Light gray background with white texts
case lightGray_white
/// Black background with white texts
case black_white
```

## :copyright: License

MIT License

Copyright (c) 2022 David Ansermot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
