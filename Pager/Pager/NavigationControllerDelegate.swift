//
//  NavigationControllerDelegate.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/21/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //println("animating from \(fromVC) to \(toVC)")
        
        if fromVC is SearchViewController && toVC is TellMeMoreViewController {
            return SearchToTellMeMoreTransition()
        }
        else {
            return DefaultFadeTransition()
        }
        
    }
}
