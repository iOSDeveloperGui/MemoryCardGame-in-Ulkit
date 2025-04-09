//
//  HomeViewController.swift
//  MemoryGame
//
//  Created by iOS Developer on 09/04/25.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - Property
    private let contentView: HomeView
    
    //MARK: - Initializer
    init(contentView: HomeView){
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AppLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupConstraints()
    }

    // MARK: - AddSubViewsMethod
    private func addSubViews(){
        
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints(){
        
    }

}
