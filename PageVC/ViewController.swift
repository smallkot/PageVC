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
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 1...9 {
            let image = UIImage(named: "\(index)")!
            images.append(image)
        }
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as UIPageViewController
        self.pageViewController.dataSource = self
        
        let startingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as PageContentViewController
        let viewControllers = [startingViewController]
        self.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        if self.images.count == 0 || index >= self.images.count {
            return nil
        }
        
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as PageContentViewController
                
        pageContentViewController.imageName = "\(index)"
        pageContentViewController.index = index
        
        return pageContentViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let pageContentViewController = viewController as PageContentViewController
        var index = pageContentViewController.index
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let pageContentViewController = viewController as PageContentViewController
        var index = pageContentViewController.index
        
        index++
        
        if index == NSNotFound {
            return nil
        }
        
        if index == self.images.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index++)
    }

}

