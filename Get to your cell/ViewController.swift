//
//  ViewController.swift
//  Get to your cell
//
//  Created by ヴィヤヴャハレ・アディティヤ on 01/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    let namesTableView = UITableView()
    let imagesColletionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow, UIColor.orange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        namesTableView.delegate = self
        
        //        setupTableView()
        setupCollectionView()
    }
}

//MARK: Configure tableView
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func setupTableView() {
////        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//
//        ])
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//}

//MARK: Configure collectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView() {
        imagesColletionView.delegate = self
        imagesColletionView.dataSource = self
        imagesColletionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.cellIdentifier)
        view.addSubview(imagesColletionView)
        
        // Set up horizontal scrolling and paging
        if let layout = imagesColletionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            imagesColletionView.isPagingEnabled = true
            imagesColletionView.setCollectionViewLayout(layout, animated: false)
        }
        
        //Set constraints
        imagesColletionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagesColletionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesColletionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            imagesColletionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -10),
            imagesColletionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        cell.backgroundColor = colors[indexPath.row]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = collectionView.bounds.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
