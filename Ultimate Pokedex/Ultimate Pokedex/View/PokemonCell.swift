//
//  PokemonCell.swift
//  Ultimate Pokedex
//
//  Created by Ali Eldeeb on 11/30/22.
//

import Foundation

import UIKit

class PokemonCell: UICollectionViewCell{
    //MARK: - Properties
    var pokemon: Pokemon?{
        didSet{
            guard let pokemon = pokemon else{ return }
            backgroundColor = pokemon.backgroundColor
            self.nameLabel.text = pokemon.name.capitalized
            self.typeLabel.text = pokemon.type.capitalized
            Service.shared.fetchImage(pokemon: pokemon) { data, error in
                if let data = data{
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = UIImage(data: data)
                    }
                    
                }
            }
            layer.shadowColor = pokemon.backgroundColor.cgColor
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel().makeLabel(textColor: .white, withFont: UIFont.boldSystemFont(ofSize: 16))
        return label
    }()
    
    private let typeBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground.withAlphaComponent(0.25)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel().makeLabel(textColor: .white, withFont: UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func configureCellComponents(){
        layer.cornerRadius = 10
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        addSubview(nameLabel)
        nameLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 12, paddingLeading: 8)
        
        addSubview(typeBackgroundView)
        addSubview(typeLabel)
        typeLabel.anchor(top: nameLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, paddingTop: 12, paddingLeading: 12)
        typeBackgroundView.anchor(top: typeLabel.topAnchor, leading: typeLabel.leadingAnchor, bottom: typeLabel.bottomAnchor, trailing: typeLabel.trailingAnchor, paddingTop: -5, paddingLeading: -5, paddingBottom: -5, paddingTrailing: -5)
        
        addSubview(pokemonImageView)
        pokemonImageView.anchor(top: nameLabel.bottomAnchor, leading: typeBackgroundView.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 2, paddingLeading: 2, paddingBottom: 4, paddingTrailing: 2)
    }
    
}
