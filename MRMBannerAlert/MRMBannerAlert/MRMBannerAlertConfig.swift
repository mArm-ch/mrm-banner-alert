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
    public init() {}
    
    var titleColor: UIColor                 = .darkGray
    var titleFont: UIFont                   = .boldSystemFont(ofSize: 17.0)
    var titleAlignment: NSTextAlignment     = .left
    
    var messageColor: UIColor               = .darkGray
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
}
