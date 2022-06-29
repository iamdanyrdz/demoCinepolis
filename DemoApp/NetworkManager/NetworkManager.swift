//
//  NetworkManager.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation
import SwiftyJSON

var moviesList : [FullMovies] = []
var valueList: [String] = []
var listCategories: [String] = []
var fullCast: [Cast] = []
var mediaList: [Media] = []
var totalMovies : [Movie] = []
var routeList: [Route] = []
var fullMoviesList: [FullMovies] = []
var sizesList: [Sizes] = []
var large: String = ""
var xlarge: String = ""
var small: String = ""
var medium: String = ""
var url: String = ""

func typeResponse(responseJson: JSON, typeLogin: String, completion: @escaping (_ data: [Movie], _ route: [Route], _ result: serviceResult) -> Void) {
    switch typeLogin {
    case "LOGIN":
        debugPrint("+++RESPONSE MESSAGE: ", responseJson)
        let accessToken = responseJson["access_token"].stringValue
        let tokenType = responseJson["token_type"].stringValue
        let expiresIn = responseJson["expires_in"].intValue
        let refreshToken = responseJson["refresh_token"].stringValue
        let clientId = responseJson["as:client_id"].stringValue
        let username = responseJson["username"].stringValue
        let countryCode = responseJson["country_code"].stringValue
        let issued = responseJson[".issued"].stringValue
        let expires = responseJson[".expires"].stringValue
        debugPrint("+++++", accessToken, tokenType)
        
            let _ = GeneralKeychain.shared.addKey(keyToSave: accessToken, keyName: "access_token")
            let _ = GeneralKeychain.shared.addKey(keyToSave: tokenType, keyName: "token_type")
            let _ = GeneralKeychain.shared.addIntegerKey(keyToSave: expiresIn, keyName: "expires_in")
            let _ = GeneralKeychain.shared.addKey(keyToSave: refreshToken, keyName: "refresh_token")
            let _ = GeneralKeychain.shared.addKey(keyToSave: clientId , keyName: "as:client_id")
            let _ = GeneralKeychain.shared.addKey(keyToSave: username, keyName: "username")
            let _ = GeneralKeychain.shared.addKey(keyToSave: countryCode, keyName: "country_code")
            let _ = GeneralKeychain.shared.addKey(keyToSave: issued, keyName: ".issued")
            let _ = GeneralKeychain.shared.addKey(keyToSave: expires, keyName: ".expires")

            completion(totalMovies, routeList, .success)
    case "MOVIES":
        let movieslist = responseJson["movies"]
        let routesList = responseJson["routes"]
        
        for i in 0 ..< routesList.count {
            let routes = Route(code: routesList[i]["code"].stringValue,
                               sizes: Sizes(large: routesList[i]["sizes"]["large"].stringValue,
                                            xlarge: routesList[i]["sizes"]["x-large"].stringValue,
                                            small: routesList[i]["sizes"]["small"].stringValue,
                                            medium: routesList[i]["sizes"]["medium"].stringValue))
            routeList.append(routes)
        }
        
        for i in 0 ..< movieslist.count{
            
            let cat = movieslist[i]["categories"].arrayValue
            for i in 0 ..< cat.count {
                debugPrint(cat[i].stringValue)
                listCategories.append(cat[i].stringValue)
            }
            
            let cast = movieslist[i]["cast"].arrayValue
            for i in 0 ..< cast.count {
                let label = cast[i]["label"].stringValue
                let value =  cast[i]["value"].arrayValue
                for i in 0 ..< value.count {
                    debugPrint(value[i].stringValue)
                    valueList.append(value[i].stringValue)
                }
                fullCast.append(Cast(value: valueList, label: label))
            }
            
            debugPrint(fullCast)
            
            let media = movieslist[i]["media"].arrayValue
            for i in 0 ..< media.count {
                let mediaItem = Media(code: media[i]["resource"].stringValue,
                                      resource: media[i]["code"].stringValue,
                                      type: media[i]["type"].stringValue)
                mediaList.append(mediaItem)
            }
            
            let fullmovies = Movie(
                originalName: movieslist[i]["original_name"].stringValue,
                code: movieslist[i]["code"].stringValue,
                genre: movieslist[i]["genre"].stringValue,
                id: movieslist[i]["id"].intValue,
                releaseDate: movieslist[i]["release_date"].stringValue,
                synopsis: movieslist[i]["synopsis"].stringValue,
                name: movieslist[i]["name"].stringValue,
                cast: fullCast,
                categories: listCategories,
                length: movieslist[i]["length"].stringValue,
                position: movieslist[i]["position"].intValue,
                media: mediaList,
                distributor: movieslist[i]["distributor"].stringValue,
                rating: movieslist[i]["rating"].stringValue)
            totalMovies.append(fullmovies)
        }
        
        debugPrint(totalMovies)
        debugPrint(routeList)
        let full = FullMovies(movies: totalMovies, routes: routeList)
        fullMoviesList.append(full)
        debugPrint(fullMoviesList)
        
        completion(totalMovies, routeList, .success)
    case "USER":
//        debugPrint("+++RESPONSE MESSAGE: ", responseJson)
        let email = responseJson["email"].stringValue
        let firstName = responseJson["first_name"].stringValue
        let phoneNumber = responseJson["phone_number"].stringValue
        let cardNumber = responseJson["card_number"].stringValue
        let lastName = responseJson["last_name"].stringValue
        let profilePicture = responseJson["profile_picture"].stringValue
        debugPrint("+++++INFO USER", email, firstName, lastName, cardNumber)
        
        let _ = GeneralKeychain.shared.addKey(keyToSave: email, keyName: "email")
        let _ = GeneralKeychain.shared.addKey(keyToSave: firstName, keyName: "first_name")
        let _ = GeneralKeychain.shared.addKey(keyToSave: lastName, keyName: "last_name")
        let _ = GeneralKeychain.shared.addKey(keyToSave: phoneNumber, keyName: "phone_number")
        let _ = GeneralKeychain.shared.addKey(keyToSave: cardNumber, keyName: "card_number")

            completion(totalMovies, routeList, .success)
    default:
        break
    }
}
    func urls(urlType: String) {
        switch urlType {
        case "LOGIN":
            url = "https://stage-api.cinepolis.com/v2/oauth/token"
        case "PERMISSIONS":
            break
        default:
            break
        }
    }

