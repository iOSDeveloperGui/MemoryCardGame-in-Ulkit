//
//  GameView.swift
//  MemoryGame
//
//  Created by iOS Developer on 04/04/25.
//

import UIKit

class GameView: UIView {
    
    //MARK: - Property
    private var didSetupItemSize = false
    
    //MARK: - UIComponents
    public lazy var background: UIImageView = {
        let image = UIImageView(image: UIImage(named: "bgGameScreen"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var matchLabel: UILabel = {
        let label = UILabel()
        label.text = "😸 Nice Match!"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .yellow
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCell")
        return collectionView
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddSubViewsMethod
    private func addSubViews(){
        self.addSubview(background)
        self.addSubview(timerLabel)
        self.addSubview(matchLabel)
        self.addSubview(collectionView)
    }
    
    //MARK: - SetupConstraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            timerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            timerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            matchLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            matchLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: self.timerLabel.topAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !didSetupItemSize,
           let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let totalPadding: CGFloat = 16
            let spacing: CGFloat = 4
            let numberOfItemsPerRow: CGFloat = 4
            let totalSpacing = spacing * (numberOfItemsPerRow - 1)
            let availableWidth = bounds.width - totalPadding - totalSpacing
            
            let itemWidth = max(availableWidth / numberOfItemsPerRow, 0)
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            
            didSetupItemSize = true
        }
    }


}
