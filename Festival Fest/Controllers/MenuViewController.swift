//
//  MenuViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/22/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit
import Parchment

struct ImageItem: PagingItem, Hashable, Comparable {
    let index: Int
    let title: String
    let headerImage: UIImage
    let images: [UIImage]
    
    var hashValue: Int {
        return index.hashValue &+ title.hashValue
    }
    
    static func ==(lhs: ImageItem, rhs: ImageItem) -> Bool {
        return lhs.index == rhs.index && lhs.title == rhs.title
    }
    
    static func <(lhs: ImageItem, rhs: ImageItem) -> Bool {
        return lhs.index < rhs.index
    }
}

class MenuViewController: UIViewController {

    // MARK: - Outlets
    
    
    // MARK: - Variables
    private let items = [
        ImageItem(
            index: 0,
            title: "Green",
            headerImage: UIImage(named: "green-1")!,
            images: [
                UIImage(named: "green-1")!,
                UIImage(named: "green-2")!,
                UIImage(named: "green-3")!,
                UIImage(named: "green-4")!,
                ]),
        ImageItem(
            index: 1,
            title: "Food",
            headerImage: UIImage(named: "food-1")!,
            images: [
                UIImage(named: "food-1")!,
                UIImage(named: "food-2")!,
                UIImage(named: "food-3")!,
                UIImage(named: "food-4")!,
                ])
    ]
    
    // Create our custom paging view controller.
    private let pagingViewController = CustomPagingViewController()
    
    // Store the menu insets and item size and use that to calculate
    // the height of the collection view. We will use these values later
    // to calculate the height of the menu based on the scroll.
    private let menuInsets = UIEdgeInsets(top: 22, left: 18, bottom: 12, right: 18)
    private let menuItemSize = CGSize(width: 120, height: 100)
    
    private var menuHeight: CGFloat {
        return menuItemSize.height + menuInsets.top + menuInsets.bottom
    }
    
    
    // MARK: - Setup
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Load each of the view controllers you want to embed
//        // from the storyboard.
//        let storyboard = UIStoryboard(name: kHomeStoryboard, bundle: nil)
//        let firstViewController = storyboard.instantiateViewController(withIdentifier: kHomeViewController)
////        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
//
//        // Initialize a FixedPagingViewController and pass
//        // in the view controllers.
//        let pagingViewController = FixedPagingViewController(viewControllers: [
//            firstViewController
//            ])
//
//        // Make sure you add the PagingViewController as a child view
//        // controller and contrain it to the edges of the view.
//        addChild(pagingViewController)
//        view.addSubview(pagingViewController.view)
//        view.constrainToEdges(pagingViewController.view)
//        pagingViewController.didMove(toParent: self)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingViewController.menuItemSource = .class(type: ImagePagingCell.self)
        pagingViewController.menuItemSize = .fixed(width: menuItemSize.width, height: menuItemSize.height)
        pagingViewController.menuItemSpacing = 8
        pagingViewController.menuInsets = menuInsets
        pagingViewController.borderColor = UIColor(white: 0, alpha: 0.1)
        pagingViewController.indicatorColor = .black
        
        pagingViewController.indicatorOptions = .visible(
            height: 1,
            zIndex: Int.max,
            spacing: UIEdgeInsets.zero,
            insets: UIEdgeInsets.zero
        )
        
        pagingViewController.borderOptions = .visible(
            height: 1,
            zIndex: Int.max - 1,
            insets: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        )
        
        // Add the paging view controller as a child view controller and
        // contrain it to all edges.
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        // Set our data source and delegate.
        pagingViewController.dataSource = self
        pagingViewController.delegate = self
        
        // Set the first item as the selected paging item.
        pagingViewController.select(pagingItem: items[0])
    }
    
    private func calculateMenuHeight(for scrollView: UIScrollView) -> CGFloat {
        // Calculate the height of the menu view based on the scroll view
        // content offset.
        let maxChange: CGFloat = 50
        let offset = min(maxChange, scrollView.contentOffset.y + menuHeight) / maxChange
        let height = menuHeight - (offset * maxChange)
        return height
    }
    
    private func updateMenu(height: CGFloat) {
        guard let menuView = pagingViewController.view as? CustomPagingView else { return }
        
        // Update the height constraint of the menu view.
        menuView.menuHeightConstraint?.constant = height
        
        // Update the size of the menu items.
        pagingViewController.menuItemSize = .fixed(
            width: menuItemSize.width,
            height: height - menuInsets.top - menuInsets.bottom
        )
        
        // Invalidate the collection view layout and call layoutIfNeeded
        // to make sure the collection is updated.
        pagingViewController.collectionViewLayout.invalidateLayout()
        pagingViewController.collectionView.layoutIfNeeded()
    }

}

// Create our own custom paging view and override the layout
// constraints. The default implementation constrains the menu view
// to the page menu, but we want to keep them independent and store
// the height constraint so that we can update it later.
class CustomPagingView: PagingView {
    
    var menuHeightConstraint: NSLayoutConstraint?
    
    override func setupConstraints() {
        pageView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        menuHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: options.menuHeight)
        menuHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            
            pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageView.topAnchor.constraint(equalTo: topAnchor)
            ])
    }
}


// Create a custom paging view controller and override the view with
// our own custom subclass.
class CustomPagingViewController: PagingViewController<ImageItem> {
    
    override func loadView() {
        view = CustomPagingView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view
        )
    }
}



extension MenuViewController: PagingViewControllerDataSource {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
//        let viewController = ImagesViewController(
//            images: items[index].images,
//            options: pagingViewController.options
//        )

        let viewController = UIStoryboard(name: kHomeStoryboard, bundle: nil).instantiateViewController(withIdentifier: kHomeViewController) as! HomeViewController
        
        // Set the `ImagesViewControllerDelegate` that allows us to get
        // notified when the images view controller scrolls.
//        viewController.delegate = self
        
        // Inset the collection view with the height of the menu.
//        let insets = UIEdgeInsets(top: menuHeight, left: 0, bottom: 0, right: 0)
//        viewController.collectionView.contentInset = insets
//        viewController.collectionView.scrollIndicatorInsets = insets
//        viewController.view.bounds = CGRect(x: 0, y: menuHeight, width: view.bounds.width, height: view.bounds.height)
        
        return viewController
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        return items[index] as! T
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int{
        return items.count
    }
    
}

extension MenuViewController: ImagesViewControllerDelegate {
    
    func imagesViewControllerDidScroll(_ imagesViewController: ImagesViewController) {
        // Calculate the menu height based on the content offset of the
        // currenly selected view controller and update the menu.
        let height = calculateMenuHeight(for: imagesViewController.collectionView)
        updateMenu(height: height)
    }
    
}

extension MenuViewController: PagingViewControllerDelegate {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, isScrollingFromItem currentPagingItem: T, toItem upcomingPagingItem: T?, startingViewController: UIViewController, destinationViewController: UIViewController?, progress: CGFloat) {
        guard let destinationViewController = destinationViewController as? ImagesViewController else { return }
        guard let startingViewController = startingViewController as? ImagesViewController else { return }
        
        // Tween between the current menu offset and the menu offset of
        // the destination view controller.
        let from = calculateMenuHeight(for: startingViewController.collectionView)
        let to = calculateMenuHeight(for: destinationViewController.collectionView)
        let height = ((to - from) * abs(progress)) + from
        updateMenu(height: height)
    }
    
}
