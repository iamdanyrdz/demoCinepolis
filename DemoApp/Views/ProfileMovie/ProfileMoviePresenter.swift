//
//  ProfileMoviePresenter.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit

class ProfileMoviePresenter: ProfileMoviePresenterProtocol {
    
    weak private var view: ProfileMovieViewProtocol?
    var interactor: ProfileMovieInteractorProtocol?
    private let router: ProfileMovieWireframeProtocol

    init(interface: ProfileMovieViewProtocol, interactor: ProfileMovieInteractorProtocol?, router: ProfileMovieWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}
