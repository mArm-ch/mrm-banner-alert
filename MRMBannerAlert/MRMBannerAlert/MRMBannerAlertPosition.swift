//
//  MRMBannerAlertPosition.swift
//  MRMBannerAlert
//
//  Created by David Ansermot on 14.09.22.
//

import UIKit

/// Start position for the banner
///
enum MRMBannerAlertPosition {
    case top
    case topRight
    case right
    case bottomRight
    case bottom
    case bottomLeft
    case left
    case topLeft
    
    /// Returns the frame for the banner corresponding
    /// to the position
    ///
    /// - Author: David Ansermot
    /// - Date: 2022.09.13
    ///
    /// - Parameter margin: The margin of the banner
    /// - Parameter bannerSize: The banner size
    /// - Parameter screen: The bounds of the screen
    /// - Returns: `CGRect`
    ///
    func frame(margin: Double, bannerSize: CGSize, screen: CGRect) -> CGRect {
        switch self {
        case .top:
            return CGRect(x: margin, y: -(bannerSize.height + margin),
                          width: bannerSize.width, height: bannerSize.height)
        case .topRight:
            return CGRect(x: screen.width, y: margin,
                          width: bannerSize.width, height: bannerSize.height)
        case .right:
            return CGRect(x: screen.width, y: (screen.height / 2) - (bannerSize.height / 2),
                          width: bannerSize.width, height: bannerSize.height)
        case .bottomRight:
            return CGRect(x: screen.width, y: screen.height - (bannerSize.height + margin),
                          width: bannerSize.width, height: bannerSize.height)
        case .bottom:
            return CGRect(x: margin, y: screen.height,
                          width: bannerSize.width, height: bannerSize.height)
        case .bottomLeft:
            return CGRect(x: -screen.width, y: screen.height - (bannerSize.height + margin),
                          width: bannerSize.width, height: bannerSize.height)
        case .left:
            return CGRect(x: -screen.width, y: (screen.height / 2) - (bannerSize.height / 2),
                          width: bannerSize.width, height: bannerSize.height)
        case .topLeft:
            return CGRect(x: -screen.width, y: margin,
                          width: bannerSize.width, height: bannerSize.height)
        }
    }
    
    
    /// Pop in a banner
    ///
    /// - Author: David Ansermot
    /// - Date: 2022.09.23
    ///
    /// - Parameter banner: The banner to pop
    /// - Parameter screen: The screen bounds
    /// - Parameter config: The banner configuration
    /// - Returns: `Void`
    ///
    func popin(banner: MRMBannerAlert, screen: CGRect, config: MRMBannerAlertConfig) {
        switch self {
        case .top:
            banner.frame.origin.y = config.margin
        case .topRight:
            banner.frame.origin.x = config.margin
        case .right:
            banner.frame.origin.x = config.margin
        case .bottomRight:
            banner.frame.origin.x = config.margin
        case .bottom:
            banner.frame.origin.y = screen.height - (banner.frame.height + config.margin)
        case .bottomLeft:
            banner.frame.origin.x = config.margin
        case .left:
            banner.frame.origin.x = config.margin
        case .topLeft:
            banner.frame.origin.x = config.margin
        }
    }
    
    /// Pop out a banner
    ///
    /// - Author: David Ansermot
    /// - Date: 2022.09.23
    ///
    /// - Parameter banner: The banner to pop
    /// - Parameter screen: The screen bounds
    /// - Parameter config: The banner configuration
    /// - Returns: `Void`
    ///
    func popout(banner: MRMBannerAlert, screen: CGRect, config: MRMBannerAlertConfig) {
        switch self {
        case .top:
            banner.frame.origin.y = -(banner.frame.height + config.margin)
        case .topRight:
            banner.frame.origin.x = screen.width
        case .right:
            banner.frame.origin.x = screen.width
        case .bottomRight:
            banner.frame.origin.x = screen.width
        case .bottom:
            banner.frame.origin.y = screen.height
        case .bottomLeft:
            banner.frame.origin.x = -screen.width
        case .left:
            banner.frame.origin.x = -screen.width
        case .topLeft:
            banner.frame.origin.x = -screen.width
        }
    }
}
