//
//  DetailViewController.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/12/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel

    //MARK: - Init
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Outlets
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 2
        label.text = "Authors:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 2
        label.text = "Description:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabelsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        setViewAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpContent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    //MARK: - Helper Methods
    private func setViewAppearance() {
        view.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        title = viewModel.title
    }
    
    private func setUpViews() {
        view.addSubview(imageView)
        view.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(authorsLabel)
        
        view.addSubview(descriptionLabelsStackView)
        descriptionLabelsStackView.addArrangedSubview(descriptionTitleLabel)
        descriptionLabelsStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            labelsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            labelsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            descriptionLabelsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            descriptionLabelsStackView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 16)
        ])
    }
    
    private func setUpContent() {
        var authorsText = ""
        
        for (index, author) in  viewModel.authors.enumerated() {
            if index != 0 {
                authorsText += ", "
            }
            authorsText += author
        }
        authorsLabel.text = authorsText
        descriptionLabel.text = viewModel.description
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: viewModel.imageURL)
    }
    
}
