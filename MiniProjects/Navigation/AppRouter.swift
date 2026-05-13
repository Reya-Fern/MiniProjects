//
//  AppRouter.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 13/5/2569 BE.
//

import UIKit

enum AppRouter {

    static func open(_ project: ProjectType, from navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(
            name: project.storyboardName,
            bundle: nil
        )

        let viewController = storyboard.instantiateViewController(
            identifier: project.viewControllerID
        )

        navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
}
