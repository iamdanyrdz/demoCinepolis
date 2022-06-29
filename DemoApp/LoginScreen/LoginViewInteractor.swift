//
//  LoginViewInteractor.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation
import SwiftyJSON

class LoginViewInteractor: LoginViewInteractorProtocol {
    
    weak var presenter: LoginViewPresenterProtocol?
    
    var url: String = ""
    var urlType: String = ""
    
    
    func executeLoginAccess(usuario: String, Contraseña: String, typeLogin: String?) {
        let success = {
            (_ data: [Movie], _ route: [Route], result: serviceResult) in
            self.successAccess(permisos: data, route: route, typeLogin: "")
        }
        
        let failure = {
            (approval: serviceApproval) in
            self.failureAccess(reason: approval)
        }
        postLogin2(usuario: usuario, password: Contraseña, typeLogin: typeLogin, completion: success, failure: failure)
    }
    
    func successAccess(permisos: [Movie], route: [Route], typeLogin: String?) {
        
        let success = {
            (_ data: [Movie], _ route: [Route], result: serviceResult) in
            self.successAccessUser()
        }
        
        let failure = {
            (approval: serviceApproval) in
            self.failureAccessUser(reason: approval)
        }
        userProfile(typeLogin: "USER", completion: success, failure: failure)
    }
    
    func successAccessUser() {
        self.presenter?.loaderhide()
        self.presenter?.moviesMain()
    }
    
    func failureAccessUser(reason: serviceApproval){
        presenter?.errorAccess(reason: reason)
    }
    
    func failureAccess(reason: serviceApproval){
        presenter?.errorAccess(reason: reason)
    }
    
    func postLogin2(usuario: String, password: String, typeLogin: String?, completion: @escaping (_ data: [Movie], _ route: [Route], _ result: serviceResult) -> Void, failure: @escaping (_ approval: serviceApproval) -> Void) {
        let url = "https://stage-api.cinepolis.com/v2/oauth/token"
        guard let serviceUrl = URL(string: url) else { return }
        debugPrint(serviceUrl)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = TimeInterval(15)
        let session = URLSession(configuration: configuration)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("stage_HNYh3RaK_Test", forHTTPHeaderField: "api_key")
        debugPrint(usuario, password)
        let body = "country_code=MX&username=\(usuario)&password=\(password)&grant_type=password&client_id=IATestCandidate&client_secret=c840457e777b4fee9b510fbcd4985b68"
        debugPrint(body)
        let finalBody = body.data(using: String.Encoding.utf8)
        request.httpBody = finalBody
        session.dataTask(with: request) { data, response, error in
            self.errorProcess(error: error, description: error?.localizedDescription ?? "", failure: failure)
            if let response = response as? HTTPURLResponse {
                debugPrint("+++RESPONSE STATUS: ", response.statusCode.description)
                switch(response.statusCode) {
                case 200:
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data , options: [])
                            let responseJson = JSON(json)
                            debugPrint(responseJson)
                            typeResponse(responseJson: responseJson, typeLogin: typeLogin ?? "",  completion: completion)
                            
                        } catch {
                            self.errorProcess(error: error, description: "Algo ha fallado. Intente de nuevo por favor", failure: failure)
                        }
                    }
                case 400, 401, 404, 409:
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            let responseJson = JSON(json)
                            debugPrint(responseJson)
                            let descripMessage = responseJson["description"].stringValue.replacingOccurrences(of: "For input string: \"ERROREX\"", with: "Usuario incorrecto")
                            debugPrint(descripMessage)
                            self.errorProcess(error: error, description: descripMessage, failure: failure)
                        } catch {
                            self.errorProcess(error: error, description: "Algo ha fallado. Intente de nuevo por favor", failure: failure)
                        }
                    }
                case 500:
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            let responseJson = JSON(json)
                            self.errorProcess(error: error, description: responseJson["description"].stringValue, failure: failure)
                        } catch {
                            self.errorProcess(error: error, description: "Algo ha fallado. Intente de nuevo por favor", failure: failure)
                        }
                    }
                default:
                    self.errorProcess(error: error, description: "Algo ha fallado. Intente de nuevo por favor", failure: failure)
                }
            }
        }.resume()
    }
    
    func errorProcess(error: Error?, description: String, failure: @escaping (_ approval: serviceApproval) -> Void) {
        var approval = serviceApproval()
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut:
                approval.approval = false
                approval.code = description
                approval.businessMeaning = "Se agotó el tiempo"
                failure(approval)
            case .notConnectedToInternet:
                approval.approval = false
                approval.code = description
                approval.businessMeaning = "La conexion a internet se ha perdido"
                failure(approval)
            case .networkConnectionLost:
                approval.approval = false
                approval.code = description
                approval.businessMeaning = "La conexion a internet se ha perdido"
                failure(approval)
            default:
                approval.approval = false
                approval.code = description
                approval.businessMeaning = description
                failure(approval)
            }
        }
        if error == nil && description != "" {
            approval.approval = false
            approval.code = description
            approval.businessMeaning = description
            failure(approval)
        }
    }
    
    

    
    func userProfile(typeLogin: String?, completion: @escaping (_ data: [Movie], _ route: [Route], _ result: serviceResult) -> Void, failure: @escaping (_ approval: serviceApproval) -> Void) {
        let url = "https://stage-api.cinepolis.com/v1/members/profile?country_code=MX"
        guard let serviceUrl = URL(string: url) else { return }
        debugPrint(serviceUrl)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = TimeInterval(15)
        let session = URLSession(configuration: configuration)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("stage_HNYh3RaK_Test", forHTTPHeaderField: "api_key")
        request.setValue("\(GeneralKeychain.shared.getKey(keyName: "token_type")) \(GeneralKeychain.shared.getKey(keyName: "access_token"))", forHTTPHeaderField: "Authorization")
        debugPrint("\(GeneralKeychain.shared.getKey(keyName: "token_type")) \(GeneralKeychain.shared.getKey(keyName: "access_token"))")
        
        session.dataTask(with: request) { data, response, error in
            self.errorProcess(error: error, description: error?.localizedDescription ?? "", failure: failure)
            if let response = response as? HTTPURLResponse {
                debugPrint("+++RESPONSE STATUS: ", response.statusCode.description)
                switch(response.statusCode) {
                case 200:
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data , options: [])
                            let responseJson = JSON(json)
                            debugPrint(responseJson)
                            typeResponse(responseJson: responseJson, typeLogin: typeLogin ?? "",  completion: completion)
//                            self.presenter?.loaderhide()
//                            self.presenter?.moviesMain()
                        } catch {
                            self.errorProcess(error: error, description: "Algo ha fallado. Intente de nuevo por favor", failure: failure)
                        }
                    }
                case 400, 401, 404, 409:
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            let responseJson = JSON(json)
                            debugPrint(responseJson)
                            let descripMessage = responseJson["description"].stringValue.replacingOccurrences(of: "For input string: \"ERROREX\"", with: "Usuario incorrecto")
                            debugPrint(descripMessage)
                            self.errorProcess(error: error, description: descripMessage, failure: failure)
                        } catch {
                            self.errorProcess(error: error, description: "Algo ha fallado. Intente de nuevo por favor", failure: failure)
                        }
                    }
                case 500:
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            let responseJson = JSON(json)
                            self.errorProcess(error: error, description: responseJson["description"].stringValue, failure: failure)
                        } catch {
                            self.errorProcess(error: error, description: "Algo ha fallado. Intente de nuevo por favor", failure: failure)
                        }
                    }
                default:
                    self.errorProcess(error: error, description: "Algo ha fallado. Intente de nuevo por favor", failure: failure)
                }
            }
        }.resume()
    }
    
    func errorTimeout(error : Any,  failure: @escaping (_ approval: serviceApproval) -> Void){
        if (error as? URLError)?.code == .timedOut {
            // Handle session timeout
            print("errortime \(error)")
            var approval = serviceApproval()
            approval.approval = false
            approval.code = "-1001"
            approval.businessMeaning = "Se agotó el tiempo"
            failure(approval)
        }
    }
}

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}

enum serviceResult: String {
    /****  Response Exitoso  ****/
    case success = "Completado"

    /****  Validaciones internas iOS  ****/
    case timeout = "Se agotó el tiempo"
    case invalid = "Inválido"
    case generalerror = "Error general"

    /****  Error General  ****/
    case unknown = "Error desconocido"
    case error = "Error"

    /****  Login  ****/
    case conecctionLDAP = "Error interno"
    case incorrectPassword = "Error en contraseña"
    case noExistent = "No existe"
    case badAccess = "Error de sincronización"
    case unauthorized = "No autorizado"
    case incompleteParameters = "Error de parámetros"

}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
