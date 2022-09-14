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
class MRMBannerAlert: UIView {
    
    /// Default banner configuration
    static var defaultConfig: MRMBannerAlert.Config { return MRMBannerAlert.Config() }
    
    private(set) var title: String
    private(set) var message: String
    private(set) var config: MRMBannerAlert.Config
    
    private var viewInitialized: Bool = false
    private var screen: CGRect
    private var size: CGSize
    
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    
    var start: MRMBannerAlert.Position {
        didSet {
            if self.viewInitialized {
                self.frame = start.frame(margin: config.margin,
                                         bannerSize: self.size,
                                         screen: self.screen)
            }
        }
    }
    
    
    
    // --------------------------------------------------------
    // MARK: - View life cycle
    
    init(title: String,
         message: String,
         start: MRMBannerAlert.Position,
         config: MRMBannerAlert.Config = MRMBannerAlert.Config()) {
    
        self.title = title
        self.message = message
        self.config = config
        self.start = start
        
        // Calculate some sizes
        self.screen = UIScreen.main.bounds
        self.size = CGSize(width: self.screen.width - (2 * self.config.margin),
                           height: 0.0)
        
        // Flag init
        self.viewInitialized = true
        
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. ")
    }
    
    
    
    // --------------------------------------------------------
    // MARK: - Display method(s)
    
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
        
        let banner = MRMBannerAlert(title: title, message: message, start: start, config: config)
        banner.show(in: controller, didShowCallback: didShowCallback, didHideCallback: didHideCallback)
    }
    
    func show(in controller: UIViewController? = nil,
              didShowCallback: (() -> Void)? = nil,
              didHideCallback: (() -> Void)? = nil) {
        
        // Create alert elements
        self.createTitleLabel()
        self.createMessageLabel()
        
        // Calculate final height
        self.size.height = self.titleLabel.frame.height + self.config.padding +
                           self.messageLabel.frame.height + (2 * self.config.padding)
        
        // Setup view
        self.setupView()
        
        // Gets valid view controller
        var parentController = controller
        if parentController == nil {
            parentController = MRMBannerAlert.topViewController()
        }
        
        // Display the banner
        if let parentController = parentController {
            parentController.view.addSubview(self)
            // TODO: Add animation from config
            UIView.animate(withDuration: self.config.popinDuration,
                           delay: 0.0,
                           options: self.config.popinAnimation) {
                self.start.popin(banner: self, screen: self.screen, config: self.config)
            } completion: { done in
                didShowCallback?()
                // TODO: Add animation from config
                UIView.animate(withDuration: self.config.popoutDuration,
                               delay: self.config.alertDuration,
                               options: self.config.popoutAnimation) {
                    self.start.popout(banner: self, screen: self.screen, config: self.config)
                } completion: { done in
                    didHideCallback?()
                }
            }
        } else {
            print("\(Date()) - 🏳️‍🌈 MRMBannerAlert - Sorry, no valid parentController available for display")
        }
    }
    

    private func createTitleLabel() {
        self.titleLabel = UILabel(frame: CGRect(x: self.config.padding,
                                                y: self.config.padding,
                                                width: self.size.width - (2 * config.padding),
                                                height: 24.0))
        self.titleLabel.text = self.title
        self.titleLabel.textColor = self.config.titleColor
        self.titleLabel.textAlignment = self.config.titleAlignment
        self.titleLabel.font = self.config.titleFont
        self.titleLabel.numberOfLines = 0
        self.titleLabel.sizeToFit()
    }
    
    private func createMessageLabel() {
        self.messageLabel = UILabel(frame: CGRect(x: config.padding,
                                                  y: titleLabel.frame.maxY + config.padding,
                                                  width: self.size.width - (2 * config.padding),
                                                  height: 24.0))
        self.messageLabel.text = self.message
        self.messageLabel.textColor = self.config.messageColor
        self.messageLabel.textAlignment = self.config.messageAlignment
        self.messageLabel.font = self.config.messageFont
        self.messageLabel.numberOfLines = 0
        self.messageLabel.sizeToFit()
    }
    
    private func setupView() {
        self.frame = self.start.frame(margin: self.config.margin,
                                      bannerSize: self.size,
                                      screen: self.screen)
        self.addSubview(self.titleLabel)
        self.addSubview(self.messageLabel)
        self.backgroundColor = self.config.backgroundColor
        self.layer.cornerRadius = self.config.cornerRadius
        self.layer.shadowColor = self.config.shadowColor.cgColor
        self.layer.shadowOpacity = self.config.shadowOpacity
        self.layer.shadowOffset = self.config.shadowOffset
        self.layer.shadowRadius = self.config.shadowRadius
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
        func popin(banner: MRMBannerAlert, screen: CGRect, config: MRMBannerAlert.Config) {
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
        func popout(banner: MRMBannerAlert, screen: CGRect, config: MRMBannerAlert.Config) {
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
