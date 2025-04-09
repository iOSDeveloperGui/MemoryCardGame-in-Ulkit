//
//  GameViewController.swift
//  MemoryGame
//
//  Created by iOS Developer on 04/04/25.
//

import UIKit

class GameViewController: UIViewController {
    //MARK: - Properties
    private let contentView: GameView
    private let viewModel: CardViewModel
    
    //MARK: - Initializer
    init(contentView: GameView, viewModel: CardViewModel){
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - APPLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubViews()
        setupConstraints()
        setupCollectionView()
        didUpdateTimer()
        didUpdateCards()
        didMatchCards()
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
    
    //MARK: - SetUpCollectionView
    private func setupCollectionView(){
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }
    
    //MARK: - DidUpdateTimerMethod
    private func didUpdateTimer(){
        viewModel.startTimer()
        viewModel.didUpdateTimer = { [ weak self ] timeString in
            DispatchQueue.main.async{
                self?.contentView.timerLabel.text = "Timer: \(timeString)"
            }
        }
    }
    
    //MARK: - DidUpdateCardsMethod
    private func didUpdateCards(){
        viewModel.didUpdateCards = { [ weak self ] in
            DispatchQueue.main.async{
                self?.contentView.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - DidMatchCardsMethod
    private func didMatchCards(){
        viewModel.didMatchCard = { [ weak self ] in
            DispatchQueue.main.async{
                self?.showMatchMessage()
            }
        }
    }
    
    //MARK: - ShowMatchMessageMethod
    private func showMatchMessage(){
        contentView.matchLabel.alpha = 0
        contentView.matchLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        contentView.matchLabel.text = "😸 Nice Match!"
        
        UIView.animate(withDuration: 0.4, animations: {
            self.contentView.matchLabel.alpha = 1
            self.contentView.matchLabel.transform = CGAffineTransform.identity
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.0, options: [], animations: {
                self.contentView.matchLabel.alpha = 0
            }, completion: nil)
        }
    }
}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCollectionViewCell else{
            return UICollectionViewCell()
        }
        let card = viewModel.card(at: indexPath.item)
        cell.configure(with: card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.flipCard(at: indexPath.item)
    
    }
    
    
}
