//
//  SavedFestivalViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/15.
//

import UIKit

final class SavedFestivalViewController: UIViewController {
    
    private let dataManger = DataManager.shared
    
    // MARK: - Components
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(SavedFestivalCell.self, forCellWithReuseIdentifier: SavedFestivalCell.identifier)
        return cv
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "저장된 축제가 없습니다."
        return label
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupEmptyData()
        collectionView.reloadData()
    }
    
    // MARK: - Layout

    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(emptyLabel)
    }
    
    func setLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Configure
    
    func setupEmptyData() {
        if dataManger.savedFestivals.isEmpty {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }

}

// MARK: - Extension

extension SavedFestivalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManger.savedFestivals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedFestivalCell.identifier, for: indexPath) as? SavedFestivalCell else {
            return UICollectionViewCell()
        }
        let festival = dataManger.savedFestivals[indexPath.row]
        cell.setupData(festival)
        return cell
    }
}

extension SavedFestivalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 6)
    }
}
