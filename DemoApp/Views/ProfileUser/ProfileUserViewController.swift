//
//  ProfileUserViewController.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit

class ProfileUserViewController: UIViewController {
    
    
    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoProfile.layer.borderWidth = 1.0
        photoProfile.layer.masksToBounds = false
        photoProfile.layer.borderColor = UIColor.white.cgColor
        photoProfile.layer.cornerRadius = photoProfile.frame.size.width / 2
        photoProfile.clipsToBounds = true
        nameLabel.text = "Nombre de Usuario: \(GeneralKeychain.shared.getKey(keyName: "first_name")) \(GeneralKeychain.shared.getKey(keyName: "last_name"))"
        mailLabel.text = "Correo electronico: \(GeneralKeychain.shared.getKey(keyName: "email"))"
        cardNumberLabel.text = "Tarjeta: \(GeneralKeychain.shared.getKey(keyName: "card_number"))"
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
