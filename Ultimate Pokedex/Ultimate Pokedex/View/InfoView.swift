//
//  InfoView.swift
//  Ultimate Pokedex
//
//  Created by Ali Eldeeb on 11/30/22.
//

import UIKit

class InfoView: UIView{
    //MARK: - Properties
    private var pokemon: Pokemon
    private lazy var nameLabel: UILabel = {
        let label = UILabel().makeLabel(textColor: .label, withFont: UIFont.systemFont(ofSize: 30))
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
        iv.setDimensions(height: 225, width: 225)
        return iv
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel().makeLabel(textColor: .label, withFont: UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    private let statsTitleLabel: UILabel = {
        let label = UILabel().makeLabel(withText: "Stats:", textColor: .label, withFont: UIFont.boldSystemFont(ofSize: 16))
        return label
    }()
    
    private lazy var attackLabel: UILabel = {
        let label = UILabel().makeLabel(textColor: .label, withFont: UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    private lazy var defenseLabel: UILabel = {
        let label = UILabel().makeLabel(textColor: .label, withFont: UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel().makeLabel(textColor: .label, withFont: UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel().makeLabel(textColor: .label, withFont: UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    private lazy var attackContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        view.setDimensions(height: 17, width: 175)
        view.layer.cornerRadius = 6
        view.addSubview(attackChart)
        attackChart.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTrailing: (pokemon.attack < 175) ? CGFloat(175 - (pokemon.attack)): 0)
        return view
    }()
    
    private lazy var attackChart: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.setDimensions(height: 17)
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var defenseContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        view.setDimensions(height: 17, width: 175)
        view.layer.cornerRadius = 6
        view.addSubview(defenseChart)
        defenseChart.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTrailing: (pokemon.defense < 175) ? CGFloat(175 - (pokemon.defense)): 0)
        return view
    }()
    
    private lazy var defenseChart: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.setDimensions(height: 17)
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var heightContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        view.setDimensions(height: 17, width: 175)
        view.layer.cornerRadius = 6
        view.addSubview(heightChart)
        heightChart.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTrailing: (pokemon.height < 175) ? CGFloat(175 - (pokemon.height)): 0)
        return view
    }()
    
    private lazy var heightChart: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        view.setDimensions(height: 17)
        view.layer.cornerRadius = 6
        return view
    }()
    //A completed project that is an upgraded version of my previous pokedex app with a improved UI and has more animations and interactable features.
    private lazy var weightContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        view.setDimensions(height: 17, width: 175)
        view.layer.cornerRadius = 6
        view.addSubview(weightChart)
        weightChart.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTrailing: (pokemon.weight < 175) ? CGFloat(175 - (pokemon.weight)): 0)
        
        return view
    }()
    
    private lazy var weightChart: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.setDimensions(height: 17)
        view.layer.cornerRadius = 6
        return view
    }()
    
    
    //MARK: - Init
    //You dont need to use the default init as long as you have an init that has super.init
    //the infoView() is a convenience for calling infoView with frame of zero
    init(pokemon: Pokemon){
        self.pokemon = pokemon
        super.init(frame: .zero)
        configureViewComponentConstraints()
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func configureViewComponentConstraints(){
        backgroundColor = .white
        layer.cornerRadius = 20
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
        
        //image constraints
        addSubview(pokemonImageView)
        pokemonImageView.centerX(inView: self)
        pokemonImageView.anchor(bottom: safeAreaLayoutGuide.topAnchor, paddingBottom: -50)
        
        //name label constraints
        addSubview(nameLabel)
        nameLabel.centerX(inView: self)
        nameLabel.anchor(top: pokemonImageView.bottomAnchor, paddingTop: 15)
        
        //typLabel constraints
        addSubview(typeBackgroundView)
        addSubview(typeLabel)
        typeLabel.centerX(inView: nameLabel)
        typeLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 15)
        typeBackgroundView.anchor(top: typeLabel.topAnchor, leading: typeLabel.leadingAnchor, bottom: typeLabel.bottomAnchor, trailing: typeLabel.trailingAnchor, paddingTop: -6, paddingLeading: -12, paddingBottom: -6, paddingTrailing: -12)
        
        //description label constraints
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: typeBackgroundView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 10, paddingLeading: 8, paddingTrailing: 2)
        
        addSubview(statsTitleLabel)
        statsTitleLabel.anchor(top: descriptionLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, paddingTop: 18, paddingLeading: 8)
        
        let detailStack = UIStackView(arrangedSubviews: [attackLabel, defenseLabel, heightLabel, weightLabel])
        detailStack.axis = .vertical
        detailStack.spacing = 16
        detailStack.distribution = .fillEqually
        addSubview(detailStack)
        detailStack.anchor(top: statsTitleLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, paddingTop: 8, paddingLeading: 30)
        
        let chartStack = UIStackView(arrangedSubviews: [attackContainer, defenseContainer, heightContainer, weightContainer])
        chartStack.axis = .vertical
        chartStack.spacing = 16
        chartStack.distribution = .fillEqually
        chartStack.alignment = .leading
        addSubview(chartStack)
        chartStack.anchor(top: detailStack.topAnchor, leading: detailStack.trailingAnchor, bottom: detailStack.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingLeading: 10,paddingTrailing: 10)
       

        
    }
    
    private func configureLabel(label: UILabel, title: String, details: String){
        let attString = NSMutableAttributedString(string: "\(title)   ", attributes: [.foregroundColor : UIColor.gray, .font: UIFont.boldSystemFont(ofSize: 16)])
        attString.append(NSAttributedString(string: details, attributes: [.foregroundColor : UIColor.label, .font: UIFont.systemFont(ofSize: 16)]))
        label.attributedText = attString
    }
    
    private func setupComponents(){
        self.nameLabel.text = pokemon.name.capitalized
        self.typeLabel.text = pokemon.type.capitalized
        self.typeBackgroundView.backgroundColor = pokemon.backgroundColor
        self.descriptionLabel.text = pokemon.description
        
        Service.shared.fetchImage(pokemon: pokemon) { data, error in
            if let data = data{
                DispatchQueue.main.async {
                    self.pokemonImageView.image = UIImage(data: data)
                }
            }
        }
        configureLabel(label: attackLabel, title: "Attack", details: "\(pokemon.attack)")
        configureLabel(label: defenseLabel, title: "Defense", details: "\(pokemon.defense)")
        configureLabel(label: heightLabel, title: "Height", details: "\(Float(pokemon.height) / 10.0) m")
        configureLabel(label: weightLabel, title: "Weight", details: "\(pokemon.weight / 10) kg")

    }
    
    private func shakeButton(){
        //keyframe animation: updating one frame at a time desribing the positions and animating between them
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.y" //keypath the reciever animates
        animation.values = [0, 12, -10, 12, 0] //keyframe values to use for the animation
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]//time at which to apply a given keyframe segment
        animation.duration = 0.65
        //Determines if the value specified by the animation is added to the current render tree value to produce the new render tree value.
        animation.isAdditive = true
        pokemonImageView.layer.add(animation, forKey: "shake")
    }
    
    //MARK: - Selectors
    @objc private func handleTapGesture(sender: UITapGestureRecognizer){
            UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.shakeButton()
                self.pokemonImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            } completion: { _ in
                UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    self.pokemonImageView.transform = .identity
                }
            }
    }
}

