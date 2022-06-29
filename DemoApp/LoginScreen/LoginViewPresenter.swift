//
//  LoginViewPresenter.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation

class LoginViewPresenter: LoginViewPresenterProtocol {
    
    weak private var view: LoginViewViewProtocol?
    var interactor: LoginViewInteractorProtocol?
    private let router: LoginViewWireframeProtocol

    init(interface: LoginViewViewProtocol, interactor: LoginViewInteractorProtocol?, router: LoginViewWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func login(usuario: String, password: String, typeLogin: String) {
        interactor?.executeLoginAccess(usuario: usuario, Contraseña: password, typeLogin: typeLogin)
    }
    
    func loaderhide() {
        self.view?.loaderhide()
    }
    
    func moviesMain() {
        self.view?.moviesMain()
    }
    
    func showAlert(titulo:String, mensaje:String) {
        self.view?.showAlert(titulo: titulo, mensaje: mensaje)
    }
    
    func succesAccess(permisos: String, typeLogin: String?) {
//        view?.succesAccess(permisos: permisos, typeLogin: typeLogin)
    }
    
    func errorAccess(reason: serviceApproval) {
        view?.errorAccess(reason: reason)
    }
}
