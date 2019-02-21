//
//  VenusDetailViewController.swift
//  BubbleTeaLocation
//
//  Created by Chawakorn Suphepre on 21/2/2562 BE.
//  Copyright © 2562 Chawakorn Suphepre. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class VenueDetailViewController: UIViewController {
    var name: String?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(name)
        nameLabel.text = name
        Alamofire.request("https://cdn4.th.orstatic.com/userphoto/photo/1/XE/006LGFB695858E8D89950Apx.jpg")
            .responseImage(completionHandler: {res in
                self.imageView.image = res.result.value
            })
    }
}
