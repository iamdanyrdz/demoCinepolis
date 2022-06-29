//
//  MoviesViewController.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit
import SDWebImageWebPCoder

class MoviesViewController: UIViewController, MoviesViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var presenter: MoviesPresenterProtocol?
    var shows: [Movie] = []
    var routes: [Route] = []
    var heightCollectionMovies: Int = 0

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesConstraint: NSLayoutConstraint!
    @IBOutlet weak var bodyConstraint: NSLayoutConstraint!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var profileButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.createTVShow()
        loader.startAnimating()
        loader.isHidden = false
        profileButton.isUserInteractionEnabled = true
        definirCeldas()
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func definirCeldas(){
        let celdaMovies = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        moviesCollectionView.register(celdaMovies, forCellWithReuseIdentifier: "MoviesCell")
    }
    
    func succesShows(shows: [Movie], route: [Route]) {
        DispatchQueue.main.async {
            self.shows = shows
            self.routes = route
            self.heightCollectionMovies = (shows.count + 1) * 168
            self.moviesConstraint.constant = CGFloat(self.heightCollectionMovies)
            self.bodyConstraint.constant = CGFloat(self.heightCollectionMovies + 100)
            self.moviesCollectionView.reloadData()
            self.loader.stopAnimating()
            self.loader.isHidden = true
        }
        
    }
    
    @IBAction func profileView(_ sender: Any) {
        DispatchQueue.main.async {
            debugPrint("Ver perfil")
            let profileUser = ProfileUserViewController()
            profileUser.modalPresentationStyle = .popover
            self.present(profileUser, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message , preferredStyle: .actionSheet)
            let alertActionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertActionOk)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func loginView() {
        DispatchQueue.main.async {
            let login = LoginViewRouter.createModule()
            self.navigationController?.pushViewController(login, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCollectionViewCell
        if shows.count != 0 {
            let currentShow = shows[indexPath.row]
            cell.layer.cornerRadius = 15
            cell.movieName.text = currentShow.name
            cell.releaseDateMovie.text = currentShow.originalName
            cell.raitingMovie.text = "\(currentShow.rating)"
            cell.descriptionMovie.text = currentShow.distributor
            
            if let urlImage = currentShow.media[indexPath.row].resource, urlImage != "" {
                cell.movieImage.sd_setImage(with: URL(string: urlImage), placeholderImage: UIImage(named: "cinepolisLogo")) { image, error, cache, url in
                } 
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let ancho:CGFloat = moviesCollectionView.frame.size.width
            let alto:CGFloat = 320
            let size = CGSize.init(width: ancho, height: alto)
            return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("selecciono")
        let currentShow = shows[indexPath.row]
//        debugPrint(currentShow.image?.original ?? "")
        DispatchQueue.main.async {
            
            let profileMovie = ProfileMovieRouter.createModule(name: currentShow.name,
                                                               image: currentShow.media[indexPath.row].resource ?? "",
                                                               descriptionMovie: currentShow.synopsis,
                                                               raiting: currentShow.rating,
                                                               language: "",
                                                               country: currentShow.distributor,
                                                               status: "")
            self.navigationController?.pushViewController(profileMovie, animated: true)
        }
        
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func toImage() -> UIImage? {
            if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
                return UIImage(data: data)
            }
            return nil
        }
}
