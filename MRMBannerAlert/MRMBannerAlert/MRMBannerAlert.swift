//
//  MRMBannerAlert.swift
//  MRMBannerAlert
//
//  Created by David Ansermot on 11.09.22.
//

import UIKit

/// A banner style alert displayable in multiple positions
///
///
/// - Author: David Ansermot
/// - Version: 1.0.0
///
class MRMBannerAlert: UIView {
    
    private(set) var title: String
    private(set) var message: String
    private(set) var config: MRMBannerAlertConfig
    
    private var viewInitialized: Bool = false
    private var screen: CGRect
    private var size: CGSize
    
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    
    private var hideCallback: (() -> Void)?
    
    /// Start position of the banner
    ///
    /// If the view is already initialized,
    /// changing the position will re-position the banner
    ///
    var start: MRMBannerAlertPosition {
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
    
    
    /// Initialize the banner
    ///
    /// - Author: David Ansermot
    ///
    /// - Parameter title: The title displayed in the banner
    /// - Parameter message: The message displayed in the banner
    /// - Parameter start: The start position of the banner (off scene)
    /// - Parameter config: Configuration of the banner *(default: `MRMBannerAlertConfig()`)*
    /// - Returns: `MRMBannerAlert`
    ///
    init(title: String,
         message: String,
         start: MRMBannerAlertPosition,
         config: MRMBannerAlertConfig = MRMBannerAlertConfig()) {
    
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
    
    /// Optional initialized (NOT IMPLEMENTED)
    ///
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. ")
    }
    
    
    
    // --------------------------------------------------------
    // MARK: - Display method(s)
    
    /// Show a banner
    ///
    /// - Author: David Ansermot
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
                     start: MRMBannerAlertPosition,
                     config: MRMBannerAlertConfig = MRMBannerAlertConfig(),
                     in controller: UIViewController? = nil,
                     didShowCallback: (() -> Void)? = nil,
                     didHideCallback: (() -> Void)? = nil) {
        
        let banner = MRMBannerAlert(title: title, message: message, start: start, config: config)
        banner.show(in: controller, didShowCallback: didShowCallback, didHideCallback: didHideCallback)
    }
    
    
    /// Show the current banner
    ///
    /// - Author: David Ansermot
    ///
    /// - Parameter in: The controller to display in. *(default: `nil`, means it will take the top view controller)*
    /// - Parameter didShowCallback: Callback when the banner alert is shown *(default: `nil`)*
    /// - Parameter didHideCallback: Callback when the banner alert is hidden *(default: `nil`)*
    /// - Returns: `Void`
    ///
    func show(in controller: UIViewController? = nil,
              didShowCallback: (() -> Void)? = nil,
              didHideCallback: (() -> Void)? = nil) {
        
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
            UIView.animate(withDuration: self.config.popinDuration,
                           delay: 0.0,
                           options: self.config.popinAnimation) {
                self.start.popin(banner: self, screen: self.screen, config: self.config)
            } completion: { done in
                didShowCallback?()
                if self.config.alertDuration > 0 {
                    self.hideBanner(delay: self.config.alertDuration,
                                    didHideCallback: didHideCallback)
                } else {
                    self.hideCallback = didHideCallback
                }
            }
        } else {
            print("\(Date()) - 🏳️‍🌈 MRMBannerAlert - Sorry, no valid parentController available for display")
        }
    }
    
    
    /// Hides the banner
    ///
    /// - Author: David Ansermot
    ///
    /// - Important: `private`
    ///
    /// - Parameter delay: The delay before hide *(default: 0.0)*
    /// - Parameter didHideCallback: Callback to know when banner is hidden *(default: `nil`)*
    /// - Returns: `Void`
    ///
    private func hideBanner(delay: TimeInterval = 0.0, didHideCallback: (() -> Void)? = nil) {
        UIView.animate(withDuration: self.config.popoutDuration,
                       delay: delay,
                       options: self.config.popoutAnimation) {
            self.start.popout(banner: self, screen: self.screen, config: self.config)
        } completion: { done in
            didHideCallback?()
        }
    }
    
    
    
    // --------------------------------------------------------
    // MARK: - Setup methods
    
    /// Setup the banner view itself
    ///
    /// - Author: David Ansermot
    ///
    /// - Important: `private`
    ///
    /// - Returns: `Void`
    ///
    private func setupView() {
        
        // Create alert elements
        self.createTitleLabel()
        self.createMessageLabel()
        
        // Calculate final height
        self.size.height = self.titleLabel.frame.height + self.config.padding +
                           self.messageLabel.frame.height + (2 * self.config.padding)
        
        // Configure the banner root view
        self.createBannerView(titleLabel: self.titleLabel,
                              messageLabel: self.messageLabel)
    }
    
    /// Create the title label and setup
    ///
    /// - Author: David Ansermot
    ///
    /// - Important: `private`
    ///
    /// - Returns: `Void`
    ///
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
    
    /// Create the title label and setup
    ///
    /// - Author: David Ansermot
    ///
    /// - Important: `private`
    ///
    /// - Returns: `Void`
    ///
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
    
    /// Create the root banner view
    ///
    /// - Important: `private`
    ///
    /// - Parameter titleLabel: The label for the title
    /// - Parameter messageLabel: The label for the messages
    /// - Returns: `Void`
    ///
    private func createBannerView(titleLabel: UILabel, messageLabel: UILabel) {
        self.frame = self.start.frame(margin: self.config.margin,
                                      bannerSize: self.size,
                                      screen: self.screen)
        self.addSubview(titleLabel)
        self.addSubview(messageLabel)
        self.backgroundColor = self.config.backgroundColor
        self.layer.cornerRadius = self.config.cornerRadius
        self.layer.borderWidth = self.config.borderWidth
        self.layer.borderColor = self.config.borderColor.cgColor
        
        self.layer.shadowColor = self.config.shadowColor.cgColor
        self.layer.shadowOpacity = self.config.shadowOpacity
        self.layer.shadowOffset = self.config.shadowOffset
        self.layer.shadowRadius = self.config.shadowRadius
    }
    
    
    
    // --------------------------------------------------------
    // MARK: - View events
    
    
    /// Hides the banner on click
    ///
    /// - Author: David Ansermot
    ///
    /// - Parameter touches: Set of touches
    /// - Parameter event: The event
    /// - Returns: `Void`
    ///
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count >= 1 {
            self.hideBanner(didHideCallback: self.hideCallback)
        }
    }
    
    
    
    // --------------------------------------------------------
    // MARK: - Helper methods
    
    /// Retrieve the most top visible view controller
    ///
    /// - Author: David Ansermot
    ///
    /// - Important: `internal`, `static`
    ///
    /// - Returns: `UIViewController`
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
}
