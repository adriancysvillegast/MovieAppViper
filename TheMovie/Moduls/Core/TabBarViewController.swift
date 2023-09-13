//
//  TabBarViewController.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 11/9/23.
//

import UIKit

class TabBarViewController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        setupVCs()
    }
    
    // MARK: - Methods
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {

        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.tintColor = .label
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }

    func setupVCs() {
            viewControllers = [
                createNavController(for: BrowserRouter().showBrowser(), title: NSLocalizedString("Movies", comment: ""), image: UIImage(systemName: "play.tv")!),
                createNavController(for: TVRouter().showTVModul(), title: NSLocalizedString("TV Shows", comment: ""), image: UIImage(systemName: "play.rectangle.on.rectangle")!)
            ]
        }

}

