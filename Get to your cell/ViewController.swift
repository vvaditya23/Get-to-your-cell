//
//  ViewController.swift
//  Get to your cell
//
//  Created by ヴィヤヴャハレ・アディティヤ on 01/11/23.
//

import UIKit

class ViewController: UIViewController {
    //UI elements
    let namesTableView = UITableView()
    let imagesColletionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //data to go into collection view and tableview
    let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow, UIColor.orange, UIColor.black, UIColor.purple, UIColor.systemPink, UIColor.brown, UIColor.systemIndigo, UIColor.lightGray, UIColor.darkGray, UIColor.cyan, UIColor.magenta, UIColor.systemMint, UIColor.systemTeal]
    let names = ["Red", "Green", "Blue", "Yellow", "Orange", "Black", "Purple", "Pink", "Brown", "Indigo", "light Gray", "Dark Gray", "Cyan", "Magenta", "Mint", "Teal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
    }
}

//MARK: Configure tableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        namesTableView.delegate = self
        namesTableView.dataSource = self
        namesTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellIdentifier)
        view.addSubview(namesTableView)
        
        //set constranints
        namesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namesTableView.topAnchor.constraint(equalTo: imagesColletionView.bottomAnchor),
            namesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            namesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            namesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellIdentifier, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scrollToCollectionViewItem(at: indexPath)   //pass the index number of selection to collection view.
    }
}

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
    func scrollToCollectionViewItem(at indexPath: IndexPath) {
        // Determine the corresponding index path in the collection view
        let collectionViewIndexPath = IndexPath(item: indexPath.row, section: 0)
        
        // Scroll to the item in the collection view
        imagesColletionView.scrollToItem(at: collectionViewIndexPath, at: .centeredHorizontally, animated: true)
    }

}
//enables horizontal scroll
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = collectionView.bounds.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
