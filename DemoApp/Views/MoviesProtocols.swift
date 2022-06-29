//
//  MoviesProtocols.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation

//MARK: Wireframe -
protocol MoviesWireframeProtocol: AnyObject {
    
}
//MARK: Presenter -
protocol MoviesPresenterProtocol: AnyObject {
    func createTVShow()
    func succesAccess(permisos: [Movie], route: [Route])
    func showAlert(title: String, message: String)
    func loginView()
}

//MARK: Interactor -
protocol MoviesInteractorProtocol: AnyObject {
    var presenter: MoviesPresenterProtocol?  { get set }
    func willRetriveShows()
}

//MARK: View -
protocol MoviesViewProtocol: AnyObject {

    var presenter: MoviesPresenterProtocol?  { get set }
    func showAlert(title: String, message: String)
    func succesShows(shows:[Movie], route: [Route])
    func loginView()
}
