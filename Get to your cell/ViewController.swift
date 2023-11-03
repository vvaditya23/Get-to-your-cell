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
    var imagesColletionView: UICollectionView!
    var currentIndex = 0
    //data to go into collection view and tableview
    let names = ["Battle Grounds Mobile India", "Book My Show", "Candy Crush", "Canva", "Clash of Clans", "Duolingo", "Hotstar", "Lensa", "Netflix", "Paytm", "Zomato/Swiggy"]
    let images = ["bgmi", "bookMyShow", "candyCrush", "canva", "coc", "duolingo", "hotstar", "lensa", "netflix", "paytm", "zomato_swiggy"]
    
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
            namesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            namesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            namesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            namesTableView.heightAnchor.constraint(equalToConstant: view.bounds.height/1.6)
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
        imagesColletionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        imagesColletionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imagesColletionView.backgroundColor = .systemBackground
        
        imagesColletionView.delegate = self
        imagesColletionView.dataSource = self
        imagesColletionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.cellIdentifier)
        view.addSubview(imagesColletionView)
        imagesColletionView.isScrollEnabled = false
        //Set constraints
        imagesColletionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagesColletionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesColletionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imagesColletionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imagesColletionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        cell.cellImageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    //used in taking data from tableview to go to respective cell
    func scrollToCollectionViewItem(at indexPath: IndexPath) {
        // Determine the corresponding index path in the collection view
        let collectionViewIndexPath = IndexPath(item: indexPath.row, section: 0)
        
        // Scroll to the item in the collection view
        imagesColletionView.scrollToItem(at: collectionViewIndexPath, at: .centeredHorizontally, animated: true)
        }
    
    ///delegate methods got disabled when implemented compositional layout
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView == imagesColletionView {
//            // Calculate the visible index based on content offset
//            let visibleRect = CGRect(origin: imagesColletionView.contentOffset, size: imagesColletionView.bounds.size)
//            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//            
//            if let indexPath = imagesColletionView.indexPathForItem(at: visiblePoint) {
//                // Scroll to the corresponding row in the table view
//                let selectedRowIndexPath = IndexPath(row: indexPath.item, section: 0)
//                namesTableView.selectRow(at: selectedRowIndexPath, animated: true, scrollPosition: .none)
//            }
//        }
//    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        // Get the visible items in the collection view
//        let visibleIndexPaths = imagesColletionView.indexPathsForVisibleItems
//        print("Data: \(visibleIndexPaths)")
//        // Assume you have a function to update the table view selection based on the visible index path
//        updateTableViewSelection(with: visibleIndexPaths)
//        }
//    func updateTableViewSelection(with visibleIndexPaths: [IndexPath]) {
//            if let firstVisibleIndexPath = visibleIndexPaths.first {
//                namesTableView.selectRow(at: IndexPath(row: firstVisibleIndexPath.row, section: 0), animated: true, scrollPosition: .none)
//            }
//        }
    
    //use in custom paging
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment in
            let section = self.images[sectionIndex]
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
        layOutSection.visibleItemsInvalidationHandler = { [weak self] visibleItems, point, environment in
            self?.currentIndex = (visibleItems.last?.indexPath.row)!
//            print("Collection view index: \(self!.currentIndex)")
            self!.namesTableView.selectRow(at: IndexPath(row: self!.currentIndex - 1, section: 0), animated: true, scrollPosition: .none)
        }
        return layOutSection
    }
}
