//
//  MoreInfoController.swift
//  Ultimate Pokedex
//
//  Created by Ali Eldeeb on 11/30/22.
//

import UIKit

class MoreInfoController: UIViewController{
    //MARK: - Properties
    private var pokemon: Pokemon
    
    private lazy var infoView: InfoView = {
        let infoView = InfoView(pokemon: pokemon)
        infoView.setDimensions(height: view.frame.height - 100, width: view.frame.width)
        return infoView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .white.withAlphaComponent(0.35)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateInfoView()
    }
    //MARK: - Init
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = pokemon.backgroundColor
        view.addSubview(infoView)
        infoView.anchor(top: view.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    private func animateInfoView(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.infoView.frame.origin.y = 325
        } completion: { _ in
            
        }

    }
    
    //MARK: - Selectors
}

