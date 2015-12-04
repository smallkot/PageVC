//
//  ViewController.swift
//  PageVC
//
//  Created by Michael Babiy on 12/22/14.
//  Copyright (c) 2014 Michael Babiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController!
    
    lazy var datasource: [UIImage] = {
        var images = [UIImage]()
        for index in 1...9 {
            guard let image = UIImage(named: "\(index)") else {return images}
            images.append(image)
        }
        
        return images
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
    }
    
    func setupViewController() {
        guard let storyboard = self.storyboard else {return}
        guard let pageViewController = storyboard.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController else {return}
        guard let startingViewController = storyboard.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController else {return}
        
        self.pageViewController = pageViewController
        self.pageViewController.dataSource = self
        self.pageViewController.setViewControllers([startingViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        if self.datasource.count == 0 || index >= self.datasource.count {
            return nil
        }
        
        guard let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController else {return nil}
        pageContentViewController.imageName = "\(index)"
        pageContentViewController.index = index
        
        return pageContentViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let pageContentViewController = viewController as? PageContentViewController else {return nil}
        var index = pageContentViewController.index
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let pageContentViewController = viewController as? PageContentViewController else {return nil}
        var index = pageContentViewController.index
        
        index++
        
        if index == NSNotFound {
            return nil
        }
        
        if index == self.datasource.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index++)
    }

}

