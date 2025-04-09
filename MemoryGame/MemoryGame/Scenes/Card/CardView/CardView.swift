//
//  CardView.swift
//  MemoryGame
//
//  Created by iOS Developer on 04/04/25.
//

import UIKit

final class CardView: UIView {
    
    //MARK: - Propeties
    public var isFlipped = true
    
    //MARK: - UIComponents
    public lazy var frontImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public lazy var backImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "backImageCard"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    //MARK: - Identifier
    var identifier: String? {
        didSet{
            if let id = identifier {
                frontImage.image = UIImage(named: id)
            }
        }
    }
    
    //MARK: - Initializer
    override init(frame: CGRect){
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews()
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddSubViewsMethod
    private func addSubViews(){
        self.addSubview(frontImage)
        self.addSubview(backImage)
    }
    
    //MARK: - SetupConstraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            frontImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            frontImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            frontImage.heightAnchor.constraint(equalToConstant: 136),
            
            backImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backImage.widthAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    //MARK: - SetupView
    private func setupView(){
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = .card
    }
    
    //MARK: - SetFlippedMethod
    func setFlipped(_ flipped: Bool, animated: Bool = true){
        isFlipped = flipped
        
        if animated{
            let fromView = flipped ? backImage : frontImage
            let toView = flipped ? frontImage : backImage
            let options: UIView.AnimationOptions = flipped ? .transitionFlipFromLeft : .transitionFlipFromRight
            
            UIView.transition(from: fromView, to: toView, duration: 0.4, options: [options, .showHideTransitionViews], completion: nil)
        } else{
            frontImage.isHidden = !flipped
            backImage.isHidden = flipped
        }
    }

}
