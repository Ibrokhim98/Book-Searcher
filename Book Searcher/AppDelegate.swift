//
//  AppDelegate.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: makeSearchViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    func makeSearchViewController() -> UIViewController {
        let bookLoader = RemoteBookLoader(client: HTTPClientRepository())
        let useCase = DefaultLoadBooksUseCase(bookLoader: bookLoader)
        let viewModel = SearchViewModel(loadUseCase: useCase)
        return SearchViewController(viewModel: viewModel)
    }

}

