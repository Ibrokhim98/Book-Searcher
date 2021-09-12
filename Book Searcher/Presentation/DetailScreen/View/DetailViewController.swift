//
//  DetailViewController.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/12/21.
//

import UIKit

class DetailViewController: UIViewController {
    private let viewModel: SearchViewModel

    //MARK: - Init
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Outlets
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
