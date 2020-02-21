
//
//  TestViewController.swift
//  FunboxStore
//
//  Created by Алексей Макаров on 21.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit
import RealmSwift

class FrontStoreViewController: UIViewController {
   
   // MARK: - Properties
   
   let dataSource = try! Realm().objects(DeviceModel.self)
   
   var currentViewControllerIndex = 0
   
   // MARK: -  Outlets
   
   @IBOutlet weak var contentView: UIView!
   
   // MARK: - Life
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    
      reload() // чтобы обновить добавленный контент
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      configurePageViewController()
   }
   
   // MARK: - Functions
   
   func reload() {
      currentViewControllerIndex = 0
      configurePageViewController()
   }
   
   func configurePageViewController() {
      
      guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else { return }
      
      pageViewController.delegate = self
      pageViewController.dataSource = self
      
      addChild(pageViewController)
      pageViewController.didMove(toParent: self)
      
      pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(pageViewController.view)
      
      let views: [String: Any] = ["pageView": pageViewController.view!]
      
      contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                metrics: nil, views: views))
      
      contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                metrics: nil, views: views))
      
      guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else { return }
      
      pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
      
   }
   
   func detailViewControllerAt(index: Int) -> DataViewController? {
      
      if index >= dataSource.count || dataSource.count == 0 {
         return nil
      }
      
      guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: DataViewController.self)) as? DataViewController else { return nil }
      
      dataViewController.index = index
      dataViewController.text = dataSource[index].title
      
      return dataViewController
   }
   
}

extension FrontStoreViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
   
//   func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//      return currentViewControllerIndex
//   }
//
//   func presentationCount(for pageViewController: UIPageViewController) -> Int {
//      return dataSource.count
//   }
   
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      
      let dataViewController = viewController as? DataViewController
      
      guard var currentIndex = dataViewController?.index else { return nil }
      
      currentViewControllerIndex = currentIndex
      
      if currentIndex == 0 {
         return nil
      }
      
      currentIndex -= 1
      return detailViewControllerAt(index: currentIndex)
   }
   
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      
      let dataViewController = viewController as? DataViewController
      
      guard var currentIndex = dataViewController?.index else { return nil }
      
      if currentIndex == dataSource.count {
         return nil
      }
      
      currentIndex += 1
      
      currentViewControllerIndex = currentIndex
      
      return detailViewControllerAt(index: currentIndex)
   }
   
   
}
