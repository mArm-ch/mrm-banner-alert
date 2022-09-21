# MRMBannerAlert

<img align="left" alt="Version : 1.0.0beta" src="https://img.shields.io/badge/Version-1.0.0beta-lightblue.svg" /> <img align="left" alt="Swift : 5" src="https://img.shields.io/badge/Swift-5-blue.svg" /> <img align="left" alt="Licence : MIT" src="https://img.shields.io/badge/Licence-MIT-blue.svg" /> <img align="left" alt="Files : 3" src="https://img.shields.io/badge/Files-3-blue.svg" />
<br /><br />

A simple, easy-to-use iOS banner alert that can be displayed in multiple positions and directions.

## :notebook: How to use (basic)

1. Import the file from ./mrm-banner-alert/MRMBannerAlert/MRMBannerAlert/MRMBannerAlert.swift
2. Call the ```show()``` static method :
```swift
@IBAction func showBannerAlert(_ sender: Any?) {
        MRMBannerAlert.show(title: "Banner title",
                            message: "Banner multiline text",
                            start: .top)
}
```

## :notebook_with_decorative_cover: How to use (extended)


## :wrench: Configuration

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
