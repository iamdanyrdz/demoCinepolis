//
//  OpenTVShow.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit

public class OpenTVShow {
    static public func startModuleWith() -> UIViewController {
        return UINavigationController.init(rootViewController: LoginViewRouter.createModule())
    }
}
