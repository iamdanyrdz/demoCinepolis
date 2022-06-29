//
//  LoginViewRouter.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit

class LoginViewRouter: LoginViewWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = LoginViewController(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
        let interactor = LoginViewInteractor()
        let router = LoginViewRouter()
        let presenter = LoginViewPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
