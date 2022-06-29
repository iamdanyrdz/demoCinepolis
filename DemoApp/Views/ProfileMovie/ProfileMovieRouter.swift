//
//  ProfileMovieRouter.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit

class ProfileMovieRouter: ProfileMovieWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(name:String, image: String, descriptionMovie: String, raiting: String, language: String, country: String, status: String) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ProfileMovieViewController(nibName: "ProfileMovieViewController", bundle: Bundle(for: ProfileMovieViewController.self))
        let interactor = ProfileMovieInteractor()
        let router = ProfileMovieRouter()
        let presenter = ProfileMoviePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        view.name = name
        view.image = image
        view.descriptionMovie = descriptionMovie
        view.raitingMovie = raiting
        view.languageMovie = language
        view.countryMovie = country
        view.statusMovie = status
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
