//
//  CardCollectionViewCell.swift
//  MemoryGame
//
//  Created by iOS Developer on 04/04/25.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    //MARK: - UIComponent
    private lazy var cardView: CardView = {
        let cardView = CardView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
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
        contentView.addSubview(cardView)
    }
    
    //MARK: - SetupConstraintsMethod
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    //MARK: - ConfigureMethod
    public func configure(with model: CardModel){
        cardView.identifier = model.identifier
        cardView.setFlipped(model.isFlipped, animated: false)
        
        if(model.isMatched){
            cardView.alpha = 0.4
            cardView.isUserInteractionEnabled = false
        } else{
            cardView.alpha = 1.0
            cardView.isUserInteractionEnabled = true
        }
    }
    
}
