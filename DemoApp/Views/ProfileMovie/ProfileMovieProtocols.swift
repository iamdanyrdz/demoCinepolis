//
//  ProfileMovieProtocols.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation

//MARK: Wireframe -
protocol ProfileMovieWireframeProtocol: AnyObject {
//    func updateSOS()
}
//MARK: Presenter -
protocol ProfileMoviePresenterProtocol: AnyObject {
    
}

//MARK: Interactor -
protocol ProfileMovieInteractorProtocol: AnyObject {
    var presenter: ProfileMoviePresenterProtocol?  { get set }
}

//MARK: View -
protocol ProfileMovieViewProtocol: AnyObject {

    var presenter: ProfileMoviePresenterProtocol?  { get set }
}
