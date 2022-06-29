//
//  LoginViewProtocols.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation

//MARK: Wireframe -
protocol LoginViewWireframeProtocol: AnyObject {
    
}
//MARK: Presenter -
protocol LoginViewPresenterProtocol: AnyObject {
    func loaderhide()
    func moviesMain()
    func showAlert(titulo: String, mensaje: String)
    func login(usuario: String, password: String, typeLogin: String)
    func succesAccess(permisos: String, typeLogin: String?)
    func errorAccess(reason: serviceApproval)
}

//MARK: Interactor -
protocol LoginViewInteractorProtocol: AnyObject {
    var presenter: LoginViewPresenterProtocol?  { get set }
    func executeLoginAccess(usuario: String, Contraseña: String, typeLogin: String?)
    
}

//MARK: View -
protocol LoginViewViewProtocol: AnyObject {

    var presenter: LoginViewPresenterProtocol?  { get set }
    func loaderhide()
    func moviesMain()
    func showAlert(titulo: String, mensaje: String)
    func succesAccess(permisos: String, typeLogin: String?)
    func errorAccess(reason: serviceApproval)
}

