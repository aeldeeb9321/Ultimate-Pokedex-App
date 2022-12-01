//
//  PokedexController.swift
//  Ultimate Pokedex
//
//  Created by Ali Eldeeb on 11/30/22.
//

import UIKit

private let reuseIdentifier = "cvIdentifier"

class PokedexController: UICollectionViewController {
    //MARK: - Properties
    private var pokemon = [Pokemon]()
    private var filteredPokemon = [Pokemon]()
    private var isFiltered = false
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.delegate = self
        bar.placeholder = "Search for a pokemon.."
        bar.barStyle = .black
        bar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        bar.sizeToFit()
        return bar
    }()
    
    private lazy var fireFilterButton: UIButton = {
        let button = UIButton().makeButton(withImage: UIImage(systemName: "flame.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), buttonColor: UIColor.systemRed, isRounded: false)
        button.setDimensions(height: 45, width: 45)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleFireTypeFilter), for: .touchUpInside)
        button.alpha = 0
        button.isHidden = true
        return button
    }()
    
    private lazy var leafFilterButton: UIButton = {
        let button = UIButton().makeButton(withImage: UIImage(systemName: "leaf")?.withTintColor(.white, renderingMode: .alwaysOriginal), buttonColor: UIColor.systemGreen, isRounded: false)
        button.setDimensions(height: 45, width: 45)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleLeafTypeFilter), for: .touchUpInside)
        button.alpha = 0
        button.isHidden = true
        return button
    }()
    
    private lazy var waterFilterButton: UIButton = {
        let button = UIButton().makeButton(withImage: UIImage(systemName: "drop.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), buttonColor: UIColor.systemBlue, isRounded: false)
        button.setDimensions(height: 45, width: 45)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleWaterTypeFilter), for: .touchUpInside)
        button.alpha = 0
        button.isHidden = true
        return button
    }()
    
    private lazy var electricFilterButton: UIButton = {
        let button = UIButton().makeButton(withImage: UIImage(systemName: "bolt.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), buttonColor: UIColor.systemYellow, isRounded: false)
        button.setDimensions(height: 45, width: 45)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleElectricTypeFilter), for: .touchUpInside)
        button.alpha = 0
        button.isHidden = true
        return button
    }()
    
    private lazy var toggleFiltersButton: UIButton = {
        let button = UIButton().makeButton(withImage: UIImage(named: "menuLines")?.withTintColor(.white, renderingMode: .alwaysOriginal), buttonColor: UIColor.systemPurple, isRounded: false)
        button.setDimensions(height: 45, width: 45)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handletoggleFilters), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureCV()
        fetchPokemonData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.942804873, green: 0.2601609826, blue: 0.03695399687, alpha: 1)
    }
    
    //MARK: - Helpers
    private func configureNavBar(){
        
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Pokédex"
        navigationController?.navigationBar.barTintColor = .white
        configureSearch(isSearching: false)
    }
    
    private func configureCV(){
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let filterButtons = UIStackView(arrangedSubviews: [fireFilterButton, leafFilterButton, waterFilterButton, electricFilterButton, toggleFiltersButton])
        filterButtons.axis = .vertical
        filterButtons.alignment = .center
        filterButtons.spacing = 5
        filterButtons.distribution = .fillEqually
        collectionView.addSubview(filterButtons)
        filterButtons.anchor( bottom: collectionView.safeAreaLayoutGuide.bottomAnchor, trailing: collectionView.safeAreaLayoutGuide.trailingAnchor, paddingBottom: 20, paddingTrailing: 20)
    }
    
    private func fetchPokemonData(){
        Service.shared.fetchPokeData { pokemon in
            self.pokemon = pokemon
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func configureSearch(isSearching: Bool){
        if isSearching{
            navigationItem.titleView = searchBar
            navigationItem.rightBarButtonItem = nil
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder()
        }else{
            searchBar.endEditing(true)
            searchBar.showsCancelButton = false
            searchBar.text = nil
            navigationItem.titleView = nil
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sparkle.magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action:  #selector(handleSearchButtonTapped))
            isFiltered = false
            self.collectionView.reloadData()
        }
    }
    
    private func dismissButtons(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
            self.toggleFiltersButton.transform = .identity
            self.fireFilterButton.alpha = 0
            self.leafFilterButton.alpha = 0
            self.waterFilterButton.alpha = 0
            self.electricFilterButton.alpha = 0
            self.collectionView.reloadData()
        } completion: { _ in
            self.fireFilterButton.isHidden = true
            self.leafFilterButton.isHidden = true
            self.waterFilterButton.isHidden = true
            self.electricFilterButton.isHidden = true
        }
    }
    
    private func animateFilters(isFiltered: Bool){
        if isFiltered{
            self.fireFilterButton.isHidden = false
            self.leafFilterButton.isHidden = false
            self.waterFilterButton.isHidden = false
            self.electricFilterButton.isHidden = false
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.toggleFiltersButton.transform = CGAffineTransform(rotationAngle: .pi)
                self.electricFilterButton.alpha = 1
                self.waterFilterButton.alpha = 1
                self.leafFilterButton.alpha = 1
                self.fireFilterButton.alpha = 1
            }
        }else{
            dismissButtons()
            self.toggleFiltersButton.setImage(UIImage(named: "menuLines")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    //MARK: - Selectors
    @objc private func handleSearchButtonTapped(){
        configureSearch(isSearching: true)
    }
    
    @objc private func handletoggleFilters(){
        isFiltered.toggle()
        animateFilters(isFiltered: isFiltered)
    }
    
    @objc private func handleLeafTypeFilter(){
        filteredPokemon = pokemon.filter({$0.type.range(of: "poison") != nil})
        collectionView.reloadData()
        dismissButtons()
        self.toggleFiltersButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    @objc private func handleFireTypeFilter(){
        filteredPokemon = pokemon.filter({$0.type.range(of: "fire") != nil})
        collectionView.reloadData()
        dismissButtons()
        self.toggleFiltersButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    @objc private func handleWaterTypeFilter(){
        filteredPokemon = pokemon.filter({$0.type.range(of: "water") != nil})
        collectionView.reloadData()
        dismissButtons()
        self.toggleFiltersButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    @objc private func handleElectricTypeFilter(){
        filteredPokemon = pokemon.filter({$0.type.range(of: "electric") != nil})
        collectionView.reloadData()
        dismissButtons()
        self.toggleFiltersButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    
}

//MARK: - UISearchBarDelegate
extension PokedexController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            isFiltered = true
            self.collectionView.reloadData()
        }else{
            isFiltered = false
            self.collectionView.reloadData()
        }
        filteredPokemon = pokemon.filter({$0.name.range(of: searchText.lowercased() ) != nil})
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configureSearch(isSearching: false)
    }
}

//MARK: - CollectionView Methods
extension PokedexController{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCell
        cell.pokemon = isFiltered ? filteredPokemon[indexPath.item]: pokemon[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltered ? filteredPokemon.count: pokemon.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPoke = isFiltered ? filteredPokemon[indexPath.item]: pokemon[indexPath.item]
        let controller = MoreInfoController(pokemon: selectedPoke)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PokedexController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

