//
//  UIViewController+Navigation.swift
//  FirebaseAuthLab
//
//  Created by Ahad Islam on 3/12/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

extension UIViewController {
    private static func resetWindow(with rootViewController: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window else {
                fatalError("Could not create scene")
        }
        
        window.rootViewController = rootViewController
    }
    
    public static func showViewController(from storyboardName: String, id viewControllerID: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        resetWindow(with: vc)
    }
    
}

