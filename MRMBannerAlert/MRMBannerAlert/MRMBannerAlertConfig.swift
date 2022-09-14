//
//  MRMBannerAlertConfig.swift
//  MRMBannerAlert
//
//  Created by David Ansermot on 14.09.22.
//

import UIKit

/// Configuration of a banner alert
///
struct MRMBannerAlertConfig {
    
    /// Pre-defined available themes enum
    ///
    public enum Theme {
        case white_darkGray
        case white_gray
        case white_lightGray
        case darkGray_white
        case gray_white
        case lightGray_white
        case black_white
    }
    
    public init() {}
    
    static let securityTopMargin                   = 24.0
    
    var titleColor: UIColor                 = .black
    var titleFont: UIFont                   = .boldSystemFont(ofSize: 17.0)
    var titleAlignment: NSTextAlignment     = .left
    
    var messageColor: UIColor               = .black
    var messageFont: UIFont                 = .systemFont(ofSize: 16.0)
    var messageAlignment: NSTextAlignment   = .left
    
    var backgroundColor: UIColor            = .white
    var shadowColor: UIColor                = .gray
    var shadowOpacity: Float                = 0.3
    var shadowOffset: CGSize                = CGSize(width: 6.0, height: 6.0)
    var shadowRadius: CGFloat               = 0.5
    
    var cornerRadius: Double                = 8.0
    var margin: Double                      = 12.0
    var padding: Double                     = 8.0
    
    var popinDuration: TimeInterval         = 0.5
    var popinAnimation: UIView.AnimationOptions = .curveEaseIn
    
    var popoutDuration: TimeInterval        = 0.5
    var popoutAnimation: UIView.AnimationOptions = .curveEaseOut
    
    var alertDuration: TimeInterval         = 2.0
    
    
    /// Returns a themed configuration from pre-defined themes list
    ///
    /// - Author: David Ansermot
    /// - Date: 2022.09.14
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
            config.backgroundColor = .white
        case .darkGray_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = .darkGray
        case .gray_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = .gray
        case .lightGray_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = .lightGray
        case .black_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = .black
        }
    
        return config
    }
}
