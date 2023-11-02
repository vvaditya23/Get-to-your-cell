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
//    let imagesColletionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var imagesColletionView: UICollectionView!
    
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
        
        // Select the default row in the table view because first cell is by default visible in the collection view.
            let defaultSelectedIndexPath = IndexPath(row: 0, section: 0)
        namesTableView.selectRow(at: defaultSelectedIndexPath, animated: true, scrollPosition: .none)
        
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
        //frame was .zero in previous code
        imagesColletionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        imagesColletionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imagesColletionView.backgroundColor = .systemBackground
        
        imagesColletionView.delegate = self
        imagesColletionView.dataSource = self
        imagesColletionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.cellIdentifier)
        view.addSubview(imagesColletionView)
        
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
    
    //used in taking data from tableview to go to respective cell
    func scrollToCollectionViewItem(at indexPath: IndexPath) {
        // Determine the corresponding index path in the collection view
        let collectionViewIndexPath = IndexPath(item: indexPath.row, section: 0)
        
        // Scroll to the item in the collection view
        imagesColletionView.scrollToItem(at: collectionViewIndexPath, at: .centeredHorizontally, animated: true)
        }
    
    //use in custom paging
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment in
            let section = self.colors[sectionIndex]
            return self.createFeaturedSection()
        }
        return layout
    }
    
    func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layOutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layOutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        //this fractional width value decides the leading & trailing partial showing of cells.
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(350))
        let layOutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layOutItem])
        
        let layOutSection = NSCollectionLayoutSection(group: layOutGroup)
        layOutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layOutSection
    }
}


////MARK: Configure collectionView
//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func setupCollectionView() {
//        imagesColletionView.delegate = self
//        imagesColletionView.dataSource = self
//        imagesColletionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.cellIdentifier)
//        view.addSubview(imagesColletionView)
//        
//        // Set up horizontal scrolling and paging
//        if let layout = imagesColletionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//            layout.minimumLineSpacing = 0
//            imagesColletionView.isPagingEnabled = true
//            imagesColletionView.setCollectionViewLayout(layout, animated: false)
//        }
//        
//        //Set constraints
//        imagesColletionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imagesColletionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            imagesColletionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
//            imagesColletionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -10),
//            imagesColletionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4)
//        ])
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return colors.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellIdentifier, for: indexPath) as! CustomCollectionViewCell
//        
//        cell.backgroundColor = colors[indexPath.row]
//        
//        return cell
//    }
//    
//    // UIScrollViewDelegate method to detect scrolling
//        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//                // Calculate the visible index based on content offset
//                let visibleRect = CGRect(origin: imagesColletionView.contentOffset, size: imagesColletionView.bounds.size)
//                let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//                if let indexPath = imagesColletionView.indexPathForItem(at: visiblePoint) {
//                    // Scroll to the corresponding row in the table view
//                    let selectedRowIndexPath = IndexPath(row: indexPath.item, section: 0)
//                    namesTableView.selectRow(at: selectedRowIndexPath, animated: true, scrollPosition: .top)
//                }
//        }
//    
//    func scrollToCollectionViewItem(at indexPath: IndexPath) {
//        // Determine the corresponding index path in the collection view
//        let collectionViewIndexPath = IndexPath(item: indexPath.row, section: 0)
//        
//        // Scroll to the item in the collection view
//        imagesColletionView.scrollToItem(at: collectionViewIndexPath, at: .centeredHorizontally, animated: true)
//    }
//
//}
////enables horizontal scroll
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = collectionView.bounds.width
//        let cellHeight = collectionView.bounds.height
//        
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
//}
