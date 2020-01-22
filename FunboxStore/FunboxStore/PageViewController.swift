//
//  PageViewController.swift
//  FunboxStore
//
//  Created by Алексей Макаров on 22.01.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit
import RealmSwift

class PageViewController: UIPageViewController {
    
    let arrayRealm = try! Realm().objects(DeviceModel.self)
    var slides = [SlideHelper]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in arrayRealm {
            let newItem = SlideHelper(name: item.title)
            slides.append(newItem)
        }
    }
    
    // MARK: - CreateVC
    
    lazy var arraySlideViewControllers: [SlideViewController] = {
        var slideVC = [SlideViewController]()
        for slide in slides {
            slideVC.append(SlideViewController(slideWith: slide))
        }
        return slideVC
    }()
    
    // MARK: - Init
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.dataSource = self
        self.delegate = self
        setViewControllers([arraySlideViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? SlideViewController else { return nil }
        if let index = arraySlideViewControllers.index(of: viewController) {
            if index > 0 {
                return arraySlideViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? SlideViewController else { return nil }
        if let index = arraySlideViewControllers.index(of: viewController) {
            if index < slides.count - 1 {
                return arraySlideViewControllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
