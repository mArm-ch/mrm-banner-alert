//
//  ViewController.swift
//  MRMBannerAlert
//
//  Created by David Ansermot on 12.09.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var topButton: UIButton!
    @IBOutlet var topRightButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var bottomRightButton: UIButton!
    @IBOutlet var bottomButton: UIButton!
    @IBOutlet var bottomLeftButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var topLeftButton: UIButton!
    
    
    let message: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sodales sem quis lorem aliquam viverra. Aliquam non egestas ex. Donec condimentum egestas semper. Nunc a diam sagittis, semper ex a, laoreet elit."
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var config = MRMBannerAlertConfig()
        self.topButton.setTitle(".top (no theme)", for: .normal)
        self.topButton.backgroundColor = config.backgroundColor
        self.topButton.tintColor = config.titleColor
        
        config = MRMBannerAlertConfig.themed(.white_darkGray)
        self.topRightButton.setTitle(".topRight (.white_darkGray)", for: .normal)
        self.topRightButton.backgroundColor = config.backgroundColor
        self.topRightButton.tintColor = config.titleColor
        
        config = MRMBannerAlertConfig.themed(.white_gray)
        self.rightButton.setTitle(".right (.white_gray)", for: .normal)
        self.rightButton.backgroundColor = config.backgroundColor
        self.rightButton.tintColor = config.titleColor
        
        config = MRMBannerAlertConfig.themed(.white_lightGray)
        self.bottomRightButton.setTitle(".bottomRight (.white_lightGray)", for: .normal)
        self.bottomRightButton.backgroundColor = config.backgroundColor
        self.bottomRightButton.tintColor = config.titleColor
        
        config = MRMBannerAlertConfig.themed(.darkGray_white)
        self.bottomButton.setTitle(".bottom (.darkGray_white)", for: .normal)
        self.bottomButton.backgroundColor = config.backgroundColor
        self.bottomButton.tintColor = config.titleColor
        
        config = MRMBannerAlertConfig.themed(.gray_white)
        self.bottomLeftButton.setTitle(".bottomLeft (.gray_white)", for: .normal)
        self.bottomLeftButton.backgroundColor = config.backgroundColor
        self.bottomLeftButton.tintColor = config.titleColor
        
        config = MRMBannerAlertConfig.themed(.lightGray_white)
        self.leftButton.setTitle(".left (.lightGray_white)", for: .normal)
        self.leftButton.backgroundColor = config.backgroundColor
        self.leftButton.tintColor = config.titleColor
        
        config = MRMBannerAlertConfig.themed(.black_white)
        self.topLeftButton.setTitle(".topLeft (.black_white)", for: .normal)
        self.topLeftButton.backgroundColor = config.backgroundColor
        self.topLeftButton.tintColor = config.titleColor
    }

    @IBAction func top(_ sender: Any?) {
        MRMBannerAlert.show(title: ".top (theme: none)",
                            message: self.message, start: .top)
    }
    
    @IBAction func topRight(_ sender: Any?) {
        MRMBannerAlert.show(title: ".topRight (theme: white_darkGrey)",
                            message: self.message,
                            start: .topRight,
                            config: MRMBannerAlertConfig.themed(.white_darkGray))
    }
    
    @IBAction func right(_ sender: Any?) {
        MRMBannerAlert.show(title: ".right (theme: white_grey)",
                            message: self.message,
                            start: .right,
                            config: MRMBannerAlertConfig.themed(.white_gray))
    }
    
    @IBAction func bottomRight(_ sender: Any?) {
        MRMBannerAlert.show(title: ".bottomRight (theme: white_lightGray",
                            message: self.message,
                            start: .bottomRight,
                            config: MRMBannerAlertConfig.themed(.white_lightGray))
    }
    
    @IBAction func bottom(_ sender: Any?) {
        MRMBannerAlert.show(title: ".bottom (theme: darkGray_white)",
                            message: self.message,
                            start: .bottom,
                            config: MRMBannerAlertConfig.themed(.darkGray_white))
    }
    
    @IBAction func bottomLeft(_ sender: Any?) {
        MRMBannerAlert.show(title: ".bottomLeft (theme: grey_white)",
                            message: self.message,
                            start: .bottomLeft,
                            config: MRMBannerAlertConfig.themed(.gray_white))
    }
    
    @IBAction func left(_ sender: Any?) {
        MRMBannerAlert.show(title: ".left (theme: grey_white)",
                            message: self.message,
                            start: .left,
                            config: MRMBannerAlertConfig.themed(.lightGray_white))
    }
    
    @IBAction func topLeft(_ sender: Any?) {
        MRMBannerAlert.show(title: ".topLeft (theme: black_white)",
                            message: self.message,
                            start: .topLeft,
                            config: MRMBannerAlertConfig.themed(.black_white))
    }

}

