//
//  MRMBannerAlertConfig.swift
//  MRMBannerAlert
//
//  Created by David Ansermot on 14.09.22.
//

import UIKit

protocol MRMBannerBackgroundColor {
    var isGradient: Bool { get }
    var color: UIColor { get set }
}

/// Configuration of a banner alert
///
struct MRMBannerAlertConfig {
    
    /// Represent a plain color background
    public struct PlainBackgroundColor: MRMBannerBackgroundColor {
        var isGradient: Bool = false
        var color: UIColor
    }
    
    /// Represent a gradient background
    public struct GradientBackgroundColor: MRMBannerBackgroundColor {
        var isGradient: Bool = true
        var color: UIColor
        var color2: UIColor
        var start: CGPoint = CGPoint(x: 0.5, y: 0.0)
        var end: CGPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    /// Default initializer
    public init() {}
    
    /// Top security margin for the banner *(default: 24.0)*
    static let securityTopMargin                   = 24.0
    
    /// Title's text color *(default: `.black`)*
    var titleColor: UIColor                         = .black
    /// Title's font *(default: `.boldSystemFont(ofSize: 17.0)`)*
    var titleFont: UIFont                           = .boldSystemFont(ofSize: 17.0)
    /// Title's text alignement *(default: `.left`)*
    var titleAlignment: NSTextAlignment             = .left
    
    /// Message's text color *(default: `.black`)*
    var messageColor: UIColor                       = .black
    /// Message's font *(default: `systemFont(ofSize: 16.0)`)*
    var messageFont: UIFont                         = .systemFont(ofSize: 16.0)
    /// Message's text alignement *(default: `.left`)*
    var messageAlignment: NSTextAlignment           = .left
    
    /// Banner's background color *(default: `PlainBackgroundColor(.white)`)*
    var backgroundColor: MRMBannerBackgroundColor   = PlainBackgroundColor(color: .white)
    
    /// Enable/disable shadow *(default: true)*
    var shadowEnabled: Bool                         = true
    /// Banner's shadow color *(default: .gray)*
    var shadowColor: UIColor                        = .gray
    /// Banner's shadow opacity *(default: 0.3)*
    var shadowOpacity: Float                        = 0.3
    /// Banner's shadow offset *(default: CGSize(width: 6.0, height: 6.0))*
    var shadowOffset: CGSize                        = CGSize(width: 6.0, height: 6.0)
    /// Banner's shadow radius *(default: 0.5)*
    var shadowRadius: CGFloat                       = 0.5
    
    /// Banner's border width
    var borderWidth: CGFloat                        = 1.0
    /// Banner's border color
    var borderColor: UIColor                        = .lightGray
    
    /// Banner's corner radius *(default: 8.0)*
    var cornerRadius: Double                        = 8.0
    /// Banner's margin *(default: 12.0)*
    var margin: Double                              = 12.0
    /// Banner's padding *(default: 8.0)*
    var padding: Double                             = 8.0
    
    /// Popin animation duration *(default: 0.5)*
    var popinDuration: TimeInterval                 = 0.5
    /// Popin animation type *(default: .curveEaseIn)*
    var popinAnimation: UIView.AnimationOptions = .curveEaseIn
    
    /// Popout animation duration *(default: 0.5)*
    var popoutDuration: TimeInterval                = 0.5
    /// Popout animation type *(default: .curveEaseOut)*
    var popoutAnimation: UIView.AnimationOptions = .curveEaseOut
    
    /// Fade in animation flag *(default: false)*
    var fadeInEnabled: Bool                         = false
    /// Fade out animation flag *(default: false)*
    var fadeOutEnabled: Bool                        = false
    
    /// Alert display time. If equal or lesser to 0,
    /// alert disappear only on click *(default: 2.0)*
    var alertDuration: TimeInterval                 = 2.0
    /// Flag to enable/disable click to hide
    var clickToHide: Bool                           = true
    
    /// Pre-defined available themes enum
    ///
    public enum Theme {
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
        /// Dark gray gradient background with white texts
        case gradientDarkGray_white
        /// Light gray gradient background with black texts
        case gradientLightGray_black
        /// White background with dark gray texts (without shadow)
        case white_darkGray_noShadow
        /// White background with gray texts (without shadow)
        case white_gray_noShadow
        /// White background with light gray texts (without shadow)
        case white_lightGray_noShadow
        /// Dark gray background with white texts (without shadow)
        case darkGray_white_noShadow
        /// Gray background with white texts (without shadow)
        case gray_white_noShadow
        /// Light gray background with white texts (without shadow)
        case lightGray_white_noShadow
        /// Black background with white texts (without shadow)
        case black_white_noShadow
        /// Dark gray gradient background with white texts (without shadow)
        case gradientDarkGray_white_noShadow
        /// Light gray gradient background with black texts (without shadow)
        case gradientLightGray_black_noShadow
    }
    
    /// Returns a themed configuration from pre-defined themes list
    ///
    /// - Author: David Ansermot
    ///
    /// - Important: `static`
    ///
    /// - Parameter theme: The theme to use
    /// - Returns: `MRMBannerAlertConfig`
    ///
    static func themed(_ theme: MRMBannerAlertConfig.Theme) -> MRMBannerAlertConfig {
        var config = MRMBannerAlertConfig()
        switch theme {
        case .white_darkGray:
            config.titleColor = .darkGray
            config.messageColor = .darkGray
        case .white_gray:
            config.titleColor = .gray
            config.messageColor = .gray
        case .white_lightGray:
            config.titleColor = .lightGray
            config.messageColor = .lightGray
            config.backgroundColor = PlainBackgroundColor(color: .white)
        case .darkGray_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = PlainBackgroundColor(color: .darkGray)
        case .gray_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = PlainBackgroundColor(color: .gray)
        case .lightGray_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = PlainBackgroundColor(color: .lightGray)
        case .black_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = PlainBackgroundColor(color: .black)
        case .gradientDarkGray_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = GradientBackgroundColor(color: .black, color2: .darkGray)
        case .gradientLightGray_black:
            config.titleColor = .black
            config.messageColor = .black
            config.backgroundColor = GradientBackgroundColor(color: .lightGray, color2: .white)
        case .white_darkGray_noShadow:
            config.titleColor = .darkGray
            config.messageColor = .darkGray
            config.shadowEnabled = false
        case .white_gray_noShadow:
            config.titleColor = .gray
            config.messageColor = .gray
            config.shadowEnabled = false
        case .white_lightGray_noShadow:
            config.titleColor = .lightGray
            config.messageColor = .lightGray
            config.backgroundColor = PlainBackgroundColor(color: .white)
            config.shadowEnabled = false
        case .darkGray_white_noShadow:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = PlainBackgroundColor(color: .darkGray)
            config.shadowEnabled = false
        case .gray_white_noShadow:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = PlainBackgroundColor(color: .gray)
            config.shadowEnabled = false
        case .lightGray_white_noShadow:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = PlainBackgroundColor(color: .lightGray)
            config.shadowEnabled = false
        case .black_white_noShadow:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = PlainBackgroundColor(color: .black)
            config.shadowEnabled = false
        case .gradientDarkGray_white_noShadow:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = GradientBackgroundColor(color: .black, color2: .darkGray)
            config.shadowEnabled = false
        case .gradientLightGray_black_noShadow:
            config.titleColor = .black
            config.messageColor = .black
            config.backgroundColor = GradientBackgroundColor(color: .lightGray, color2: .white)
            config.shadowEnabled = false
        }
    
        return config
    }
}
