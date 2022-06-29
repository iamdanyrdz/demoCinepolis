//
//  ViewController.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var nextScreen: UIButton!
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        definirCeldas()
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    func definirCeldas(){
        let celdaMovies = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        moviesCollectionView.register(celdaMovies, forCellWithReuseIdentifier: "MoviesCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    @IBAction func moviesView(_ sender: Any) {
        let vc = MoviesRouter.createModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCollectionViewCell
        cell.layer.cornerRadius = 15
        cell.movieImage.image = UIImage(named: "poster")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let ancho:CGFloat = moviesCollectionView.frame.size.width
            let alto:CGFloat = 160
            let size = CGSize.init(width: ancho, height: alto)
            return size
    }
}

