//
//  MRMBannerAlert.swift
//  MRMBannerAlert
//
//  Created by David Ansermot on 12.09.22.
//

import UIKit

/// A banner style alert displayable in multiple positions
///
///
/// - Author: David Ansermot
/// - Date: 2022.09.11
/// - Version: 1.0.0
///
class MRMBannerAlert {
    
    /// Default banner configuration
    static var defaultConfig: Config { return MRMBannerAlert.Config() }
    
    
    /// Show a banner
    ///
    /// - Author: David Ansermot
    /// - Date: 2022.09.11
    ///
    /// - Important: `static`
    ///
    /// - Parameter title: The title of the banner alert
    /// - Parameter message: The message of the banner alert
    /// - Parameter start: The start position of the banner
    /// - Parameter config: The configuration of the banner
    ///   - default: `MRMBannerAlert.Config()`
    /// - Parameter in: The controller to display in. *(default: `nil`, means it will take the top view controller)*
    /// - Parameter didShowCallback: Callback when the banner alert is shown *(default: `nil`)*
    /// - Parameter didHideCallback: Callback when the banner alert is hidden *(default: `nil`)*
    /// - Returns: `Void`
    ///
    static func show(title: String,
                     message: String,
                     start: MRMBannerAlert.Position,
                     config: MRMBannerAlert.Config = MRMBannerAlert.Config(),
                     in controller: UIViewController? = nil,
                     didShowCallback: (() -> Void)? = nil,
                     didHideCallback: (() -> Void)? = nil) {
        
        // Calculate some sizes
        let screen = UIScreen.main.bounds
        var bannerSize = CGSize(width: screen.width - (2 * config.margin),
                                height: 0.0)
        
        // Create title label
        let titleLabel = UILabel(frame: CGRect(x: config.padding,
                                               y: config.padding,
                                               width: bannerSize.width - (2 * config.padding),
                                               height: 24.0))
        titleLabel.text = title
        titleLabel.textColor = config.titleColor
        titleLabel.textAlignment = config.titleAlignment
        titleLabel.font = config.titleFont
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        // Create message label
        let messageLabel = UILabel(frame: CGRect(x: config.padding,
                                                 y: titleLabel.frame.maxY + config.padding,
                                                 width: bannerSize.width - (2 * config.padding),
                                                 height: 24.0))
        messageLabel.text = message
        messageLabel.textColor = config.messageColor
        messageLabel.textAlignment = config.messageAlignment
        messageLabel.font = config.messageFont
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        
        // Calculate final height
        bannerSize.height = titleLabel.frame.height +
                            config.padding +
                            messageLabel.frame.height +
                            (2 * config.padding)
        
        // Setup banner view
        var banner = UIView(frame: start.frame(margin: config.margin,
                                               bannerSize: bannerSize,
                                               screen: screen))
        banner.addSubview(titleLabel)
        banner.addSubview(messageLabel)
        banner.backgroundColor = config.backgroundColor
        banner.layer.cornerRadius = config.cornerRadius
        banner.layer.shadowColor = config.shadowColor.cgColor
        banner.layer.shadowOpacity = config.shadowOpacity
        banner.layer.shadowOffset = config.shadowOffset
        banner.layer.shadowRadius = config.shadowRadius
        
        // Gets valid view controller
        var parentController = controller
        if parentController == nil {
            parentController = self.topViewController()
        }
        
        // Display the banner
        if let parentController = parentController {
            parentController.view.addSubview(banner)
            // TODO: Add animation from config
            UIView.animate(withDuration: config.popinDuration,
                           delay: 0.0,
                           options: config.popinAnimation) {
                start.popin(banner: &banner, screen: screen, config: config)
            } completion: { done in
                didShowCallback?()
                // TODO: Add animation from config
                UIView.animate(withDuration: config.popoutDuration,
                               delay: config.alertDuration,
                               options: config.popoutAnimation) {
                    start.popout(banner: &banner, screen: screen, config: config)
                } completion: { done in
                    didHideCallback?()
                }
            }
        } else {
            print("\(Date()) - 🏳️‍🌈 MRMBannerAlert - Sorry, no valid parentController available for display")
        }
    }
    
    /// Retrieve the most top visible view controller
    ///
    /// - Author: David Ansermot
    /// - Date: 2022.09.12
    ///
    /// - Important: `internal`
    ///
    /// - Returns: `UIViewControoler`
    ///
    internal static func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
        
    }
    
    /// Start position for the banner
    ///
    enum Position {
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
        func popin(banner: inout UIView, screen: CGRect, config: MRMBannerAlert.Config) {
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
        func popout(banner: inout UIView, screen: CGRect, config: MRMBannerAlert.Config) {
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
    
    /// Configuration of a banner alert
    ///
    struct Config {
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
}
