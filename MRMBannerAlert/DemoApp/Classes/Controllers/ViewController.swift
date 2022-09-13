//
//  ViewController.swift
//  MRMBannerAlert
//
//  Created by David Ansermot on 12.09.22.
//

import UIKit

class ViewController: UIViewController {

    let message: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sodales sem quis lorem aliquam viverra. Aliquam non egestas ex. Donec condimentum egestas semper. Nunc a diam sagittis, semper ex a, laoreet elit."
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func top(_ sender: Any?) {
        MRMBannerAlert.show(title: "top", message: self.message, start: .top)
    }
    
    @IBAction func topRight(_ sender: Any?) {
        MRMBannerAlert.show(title: "topRight", message: self.message, start: .topRight)
    }
    
    @IBAction func right(_ sender: Any?) {
        MRMBannerAlert.show(title: "right", message: self.message, start: .right)
    }
    
    @IBAction func bottomRight(_ sender: Any?) {
        MRMBannerAlert.show(title: "bottomRight", message: self.message, start: .bottomRight)
    }
    
    @IBAction func bottom(_ sender: Any?) {
        MRMBannerAlert.show(title: "bottom", message: self.message, start: .bottom)
    }
    
    @IBAction func bottomLeft(_ sender: Any?) {
        MRMBannerAlert.show(title: "bottomLeft", message: self.message, start: .bottomLeft)
    }
    
    @IBAction func left(_ sender: Any?) {
        MRMBannerAlert.show(title: "left", message: self.message, start: .left)
    }
    
    @IBAction func topLeft(_ sender: Any?) {
        MRMBannerAlert.show(title: "topLeft", message: self.message, start: .topLeft)
    }

}

