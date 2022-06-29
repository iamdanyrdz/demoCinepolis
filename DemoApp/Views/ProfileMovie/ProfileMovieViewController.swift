//
//  ProfileMovieViewController.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit
import SDWebImageWebPCoder

class ProfileMovieViewController: UIViewController, ProfileMovieViewProtocol {
    
    var presenter: ProfileMoviePresenterProtocol?
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var closeView: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var descriptionMovieLabel: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var estatusLabel: UILabel!
    @IBOutlet weak var paisLabel: UILabel!
    @IBOutlet weak var idiomaLabel: UILabel!
    
    var name: String = ""
    var image: String = ""
    var descriptionMovie: String = ""
    var raitingMovie: String = ""
    var statusMovie: String = ""
    var countryMovie: String = ""
    var languageMovie: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameMovie.text = name
        imageMovie.sd_setImage(with: URL(string: image), completed: nil)
        descriptionLabel.text = descriptionMovie
        raitingLabel.text = "Raiting: \(raitingMovie)"
        estatusLabel.text = "Estatus: \(statusMovie)"
        paisLabel.text = "Pais: \(countryMovie)"
        idiomaLabel.text = "Idioma: \(languageMovie)"
        imageMovie.layer.cornerRadius = 15
        descriptionMovieLabel.layer.cornerRadius = 15
    }

    @IBAction func close(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
