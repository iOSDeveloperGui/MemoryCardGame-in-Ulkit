//
//  CardViewController.swift
//  MemoryGame
//
//  Created by iOS Developer on 04/04/25.
//

import UIKit

class CardViewController: UIViewController {
    
    //MARK: - Properties
    let contentView: CardView
    
    //MARK: - Initializer
    init(contentView: CardView){
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - APPLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubViews()
        setupConstraints()
        setupTapGesture()
    }
    
    //MARK: - AddSubViews
    private func addSubViews(){
        view.addSubview(contentView)
    }
    
    //MARK: - SetupConstraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //MARK: - SetupTapGesture
    private func setupTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(flip))
        contentView.addGestureRecognizer(tap)
        contentView.isUserInteractionEnabled = true
    }
    
    //MARK: - FlipMethod
    @objc private func flip(){
        contentView.setFlipped(!contentView.isFlipped)
    }
    
    //MARK: - ResetMethod
    func reset(){
        contentView.isFlipped = false
        contentView.frontImage.isHidden = true
        contentView.backImage.isHidden = false
    }
    
    

}
