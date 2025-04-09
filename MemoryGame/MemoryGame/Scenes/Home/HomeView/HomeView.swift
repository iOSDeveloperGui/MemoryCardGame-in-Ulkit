//
//  HomeView.swift
//  MemoryGame
//
//  Created by iOS Developer on 09/04/25.
//

import UIKit

class HomeView: UIView {
    
    //MARK: - UIComponents
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Memory Game 🧠"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.2
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowRadius = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
    }
    
    //MARK: - SetupConstraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
        
        ])
        
    }
    
    
}
