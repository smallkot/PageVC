//
//  PageContentViewController.swift
//  PageVC
//
//  Created by Michael Babiy on 12/22/14.
//  Copyright (c) 2014 Michael Babiy. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    
    var index = 0
    var imageName = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageContentViewController()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: ... Setup ...
    
    func setupPageContentViewController() {
        guard let aView = self.imageView else {return}
        guard let image = UIImage(named: self.imageName) else {return}
        aView.contentMode = .ScaleAspectFill
        aView.image = image
    }

}
