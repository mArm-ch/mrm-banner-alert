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
        case white_darkGrey
        case white_grey
        case darkGrey_white
        case grey_white
    }
    
    public init() {}
    
    var titleColor: UIColor                 = .darkGray
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
    static func themed(theme: MRMBannerAlertConfig.Theme) -> MRMBannerAlertConfig {
        var config = MRMBannerAlertConfig()
        switch theme {
        case .white_darkGrey:
            config.titleColor = .darkGray
            config.messageColor = .darkGray
        case .white_grey:
            config.titleColor = .gray
            config.messageColor = .gray
        case .darkGrey_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = .darkGray
        case .grey_white:
            config.titleColor = .white
            config.messageColor = .white
            config.backgroundColor = .gray
        }
    
        return config
    }
}
