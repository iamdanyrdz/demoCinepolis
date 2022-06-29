//
//  MoviesPresenter.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit

class MoviesPresenter: MoviesPresenterProtocol {
    
    weak private var view: MoviesViewProtocol?
    var interactor: MoviesInteractorProtocol?
    private let router: MoviesWireframeProtocol

    init(interface: MoviesViewProtocol, interactor: MoviesInteractorProtocol?, router: MoviesWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func succesAccess(permisos: [Movie], route: [Route]) {
        self.view?.succesShows(shows: permisos, route: route)
    }
    
    func createTVShow() {
        interactor?.willRetriveShows()
    }
    
    func showAlert(title: String, message: String) {
        self.view?.showAlert(title: title, message: message)
    }
    
    func loginView() {
        self.view?.loginView()
    }
}
