//
//  BookViewCell.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/12/21.
//

import UIKit

class BookViewCell: UITableViewCell {
    
    static let cellID = "BookViewCell"
    
    //MARK: - Outlets
    private let bookImage: UIImageView = {
        let bookImage = UIImageView()
        bookImage.contentMode = .scaleAspectFit
        bookImage.backgroundColor = .red
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        return bookImage
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.text = "Book Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = "Author1, Author2"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Methods
    private func setUpViews() {
        addSubview(bookImage)
        addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(authorsLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            bookImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bookImage.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            bookImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            bookImage.heightAnchor.constraint(equalToConstant: 100),
            bookImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            labelsStackView.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}
