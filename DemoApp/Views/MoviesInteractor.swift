//
//  MoviesInteractor.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit
import SwiftyJSON

class MoviesInteractor: MoviesInteractorProtocol {
    weak var presenter: MoviesPresenterProtocol?
    
    func willRetriveShows() {
        
        let success = {
            (_ data: [Movie], route: [Route], result: serviceResult) in
            self.successAccess(permisos: data, route: route, typeLogin: "")
        }
        
        let failure = {
            (approval: serviceApproval) in
            self.failureAccess(reason: approval)
        }
        GetMovies(typeLogin: "", completion: success, failure: failure)
        
    }
    
    func successAccess(permisos: [Movie], route: [Route], typeLogin: String?) {
        presenter?.succesAccess(permisos: permisos, route: route)
    }
    
    func failureAccess(reason: serviceApproval){
        self.presenter?.loginView()
        self.presenter?.showAlert(title: "Error", message: "Ha ocurrido un error, por favor intenta de nuevo")
    }
    
    func GetMovies(typeLogin: String?, completion: @escaping (_ data: [Movie], _ route: [Route], _ result: serviceResult) -> Void, failure: @escaping (_ approval: serviceApproval) -> Void) {
//        urlLogin(urlType: typeLogin ?? "")
        let Url = "https://stage-api.cinepolis.com/v2/movies?country_code=MX&cinemas=61"
        guard let serviceUrl = URL(string: Url) else { return }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = TimeInterval(15)
        let session = URLSession(configuration: configuration)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("stage_HNYh3RaK_Test", forHTTPHeaderField: "api_key")
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
                            typeResponse(responseJson: responseJson, typeLogin: "MOVIES", completion: completion)
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
}
