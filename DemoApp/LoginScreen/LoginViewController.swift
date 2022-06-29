//
//  LoginViewController.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit

class LoginViewController: UIViewController, LoginViewViewProtocol {
    
    var presenter: LoginViewPresenterProtocol?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loginButtonOut: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var correoTextoVista: UIView!
    @IBOutlet weak var contrasenaTextoVista: UIView!
    @IBOutlet weak var correoEtiqueta: UILabel!
    @IBOutlet weak var errorCorreoEtiqueta: UILabel!
    @IBOutlet weak var correoEtiquetaCentroYLimitacion: NSLayoutConstraint!
    @IBOutlet weak var informacionCorreoEtiquetaSuperiorLimitacion: NSLayoutConstraint!
    @IBOutlet weak var contrasenaEtiqueta: UILabel!
    @IBOutlet weak var errorContrasenaEtiqueta: UILabel!
    @IBOutlet weak var contrasenaEtiquetaCentroYLimitacion: NSLayoutConstraint!
    @IBOutlet weak var informacionContrasenaEtiquetaSuperiorLimitacion: NSLayoutConstraint!
    
    var camposDeTexto: [UITextField] = []
    var textoVistas: [UIView] = []
    var textoEtiquetas: [UILabel] = []
    var errorEtiquetas: [UILabel] = []
    var centroYLimitaciones: [NSLayoutConstraint] = []
    var superiorLimitaciones: [NSLayoutConstraint] = []
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurarVista()
        self.llenarArreglos()
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        self.checkFieldsAreEmpty(sender: sender)
        guard let email = self.emailTextField.text else { return }
        
        if email.count > 0 {
            let isValidEmail = Validation.validarEmailRegistroFormulario(emailID: email)
            
            if isValidEmail == "" {
                self.finalizaEdicionCorreoPersonalizado(remitente: self.emailTextField, mensajeError: "")
                self.comienzaEdicion(remitente: emailTextField)
                return
            } else {
                self.finalizaEdicionCorreoPersonalizado(remitente: self.emailTextField, mensajeError: isValidEmail)
            }
        } else {
            self.finalizaEdicionCorreoPersonalizado(remitente: self.emailTextField, mensajeError: "")
        }
    }
    
    @IBAction func emailStartChange(_ sender: UITextField) {
        if sender.text == "" {
            self.comienzaEdicion(remitente: sender)
            self.errorCorreoEtiqueta.isHidden = true
        } else {
            let isValidEmail = Validation.validarEmailRegistroFormulario(emailID: sender.text ?? "")
            
            if isValidEmail == "" {
                self.comienzaEdicion(remitente: self.emailTextField)
                return
            }else {
                self.finalizaEdicionCorreoPersonalizado(remitente: self.emailTextField, mensajeError: isValidEmail)
            }
        }
    }
    
    @IBAction func emailEndChanged(_ sender: UITextField) {
        guard let email = self.emailTextField.text else { return }
        
        if email.count > 0 {
            if email == "" {
                self.finalizaEdicionCorreoPersonalizado(remitente: self.emailTextField, mensajeError: "El correo no tiene formato válido")
            } else {
                let error = Validation.validarEmailRegistroFormulario(emailID: email)
                self.finalizaEdicionCorreoPersonalizado(remitente: self.emailTextField, mensajeError: error)
            }
            
            let isValidCorreo = Validation.validateEmailId(emailID: email)
            if isValidCorreo {
                self.email = email
            } else {
                return
            }
        } else {
            self.finalizaEdicionCorreoPersonalizado(remitente: self.emailTextField, mensajeError: "")
        }
    }
    
    
    @IBAction func passwordTextFieldDidChanged(_ sender: UITextField) {
        HandlErrorsTextFields.checkMaxLength(textField: self.passwordTextField, maxLength: 10)
        self.checkFieldsAreEmpty(sender: sender)
        var contrasena: String = ""
        
        guard let password = self.passwordTextField.text else { return }
        let arregloLetras = Array(password)
        if arregloLetras.contains(" ") || arregloLetras.contains("ª") || arregloLetras.contains("º"){
            self.passwordTextField.deleteBackward()
            return
        }
        contrasena = password
        let lastCharacter = contrasena.suffix(1)
        if !Validation.validateAlphaNumeric(letter: String(lastCharacter)){
            self.passwordTextField.deleteBackward()
            if self.passwordTextField.text?.count ?? 0 > 0 {
                contrasena = self.passwordTextField.text ?? ""
            } else { return }
        }
        
        if contrasena.count > 0 {
            let error = Validation.validarPasswordRegistroFormulario(password: contrasena)
            self.finalizaEdicionCorreoPersonalizado(remitente: self.passwordTextField, mensajeError: error)
            
            let isValidPassword = Validation.validatePassword(password: contrasena)
            if isValidPassword {
                self.comienzaEdicion(remitente: self.passwordTextField)
                return
            } else {
                self.finalizaEdicionCorreoPersonalizado(remitente: self.passwordTextField, mensajeError: error)
                return
            }
        } else {
            self.finalizaEdicionCorreoPersonalizado(remitente: self.passwordTextField, mensajeError: "")
        }
    }
    
    @IBAction func passwordStartChange(_ sender: UITextField) {
        if sender.text == "" {
            self.comienzaEdicion(remitente: sender)
        } else {
            let error = Validation.validarPasswordRegistroFormulario(password: sender.text ?? "")
            self.finalizaEdicionCorreoPersonalizado(remitente: self.passwordTextField, mensajeError: error)
            
            let isValidPassword = Validation.validatePassword(password: sender.text ?? "")
            if isValidPassword {
                self.comienzaEdicion(remitente: sender)
            } else {
                self.finalizaEdicionCorreoPersonalizado(remitente: self.passwordTextField, mensajeError: error)
            }
        }
    }
    
    
    @IBAction func passwordEndChange(_ sender: UITextField) {
        guard let contrasena = self.passwordTextField.text else { return }
        
        if contrasena == "" {
            self.finalizaEdicionCorreoPersonalizado(remitente: self.passwordTextField, mensajeError: "")
        } else {
            let error = Validation.validarPasswordRegistroFormulario(password: contrasena)
            self.finalizaEdicionCorreoPersonalizado(remitente: self.passwordTextField, mensajeError: error)
        }
    }
    
    
    func checkFieldsAreEmpty (sender: AnyObject) {
        if self.emailTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty {
            self.loginButtonOut.isEnabled = false
            self.loginButtonOut.backgroundColor = .lightGray
        } else {
            let isValidEmail = Validation.validarEmailRegistroFormulario(emailID: self.emailTextField.text ?? "")
            
            let isValidPassword = Validation.validatePassword(password: self.passwordTextField.text ?? "")
            
            if isValidPassword && isValidEmail == "" {
                self.loginButtonOut.isEnabled = true
                self.loginButtonOut.backgroundColor = UIColor(red: 8/255, green: 40/255, blue: 91/255, alpha: 1)
            } else {
                self.loginButtonOut.isEnabled = false
                self.loginButtonOut.backgroundColor = .lightGray
            }
        }
    }
    
    func comienzaEdicion(remitente:UITextField) {
        if let posicion = camposDeTexto.firstIndex(of: remitente) {
            print("Se comenzo la edicion en la posicion \(posicion)")
            self.centroYLimitaciones[posicion].constant = -30
            UIView.animate(withDuration: 0.5, animations: {
                self.textoEtiquetas[posicion].font = UIFont(name: "Apple SD Gothic Neo Bold", size: 14)
                self.view.layoutIfNeeded()
            }, completion: {_ in
                self.textoVistas[posicion].layer.borderColor = UIColor(red: 8/255, green: 40/255, blue: 91/255, alpha: 1).cgColor
                self.textoVistas[posicion].layer.borderWidth = 2
                self.textoEtiquetas[posicion].textColor = UIColor(red: 8/255, green: 40/255, blue: 91/255, alpha: 1)
            })
        }
    }
    
    @IBAction func iniciarSesion(_ sender: Any) {
        loader.startAnimating()
        loader.isHidden = false
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                  debugPrint("no hay datos")
                  return
              }
        presenter?.login(usuario: email.replacingOccurrences(of: "@", with: "%40", options: .literal, range: nil), password: password, typeLogin: "LOGIN")
    }
    
    func showLoader() {
        loader.startAnimating()
        loader.isHidden = false
    }
    
    func loaderhide() {
        DispatchQueue.main.async {
            self.loader.isHidden = true
            self.loader.stopAnimating()
        }
        
    }
    
    func succesAccess(permisos: String, typeLogin: String?) {
        
    }
    
    func errorAccess(reason: serviceApproval) {
        DispatchQueue.main.async {
            self.showAlert(titulo: "Error", mensaje: "Ha ocurrido un error, por favor intenta de nuevo")
        }
    }
    
    func moviesMain() {
        DispatchQueue.main.async {
            let calendario = MoviesRouter.createModule()
            self.navigationController?.pushViewController(calendario, animated: true)
        }
    }
    
    func finalizaEdicionCorreoPersonalizado(remitente: UITextField, mensajeError: String) {
        if let posicion = camposDeTexto.firstIndex(of: remitente) {
            print("Se termina la edicion en la posicion \(posicion)")
            print("Error login: \(mensajeError)")
            if mensajeError != "" && !self.errorEtiquetas[posicion].text!.isEmpty {
                self.textoVistas[posicion].layer.borderColor = UIColor(red: 203/255, green: 60/255, blue: 74/255, alpha: 1).cgColor
                self.textoVistas[posicion].layer.borderWidth = 2
                self.superiorLimitaciones[posicion].constant = 18
                self.errorEtiquetas[posicion].text = mensajeError
                self.textoEtiquetas[posicion].textColor = UIColor(red: 203/255, green: 60/255, blue: 74/255, alpha: 1)
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: {_ in
                    self.errorEtiquetas[posicion].isHidden = false
                })
            } else {
                self.textoVistas[posicion].layer.borderColor = UIColor(red: 8/255, green: 40/255, blue: 91/255, alpha: 1).cgColor
                self.textoEtiquetas[posicion].textColor = UIColor(red: 8/255, green: 40/255, blue: 91/255, alpha: 1)
                self.textoVistas[posicion].layer.borderWidth = 1.3
                if !self.errorEtiquetas[posicion].text!.isEmpty{
                    self.superiorLimitaciones[posicion].constant = 3
                    UIView.animate(withDuration: 0.2, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: { _ in
                        self.errorEtiquetas[posicion].isHidden = true
                    })
                }
            }
        }
    }
    
    func configurarVista() {
        correoTextoVista.layer.cornerRadius = 12
        correoTextoVista.layer.borderColor = UIColor(red: 8/255, green: 40/255, blue: 91/255, alpha: 1).cgColor
        correoTextoVista.layer.borderWidth = 1.3
        
        contrasenaTextoVista.layer.cornerRadius = 12
        contrasenaTextoVista.layer.borderColor = UIColor(red: 8/255, green: 40/255, blue: 91/255, alpha: 1).cgColor
        contrasenaTextoVista.layer.borderWidth = 1.3
        
        loginButtonOut.layer.cornerRadius = 12
        loginButtonOut.layer.borderWidth = 1.3
        
        mainView.layer.cornerRadius = 15
        loader.isHidden = true
    }
    
    func llenarArreglos() {
        camposDeTexto.append(emailTextField)
        camposDeTexto.append(passwordTextField)
        
        textoVistas.append(correoTextoVista)
        textoEtiquetas.append(correoEtiqueta)
        errorEtiquetas.append(errorCorreoEtiqueta)
        centroYLimitaciones.append(correoEtiquetaCentroYLimitacion)
        superiorLimitaciones.append(informacionCorreoEtiquetaSuperiorLimitacion)
        
        textoVistas.append(contrasenaTextoVista)
        textoEtiquetas.append(contrasenaEtiqueta)
        errorEtiquetas.append(errorContrasenaEtiqueta)
        centroYLimitaciones.append(contrasenaEtiquetaCentroYLimitacion)
        superiorLimitaciones.append(informacionContrasenaEtiquetaSuperiorLimitacion)
    }
    
    func showAlert(titulo:String, mensaje:String) {
        let alertController = UIAlertController(title: titulo, message: mensaje , preferredStyle: .actionSheet)
        let alertActionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertActionOk)
        self.present(alertController, animated: true, completion: nil)
    }
}
