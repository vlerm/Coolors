//
//  CoolorsListViewController.swift
//  Coolors
//
//  Created by Вадим Лавор on 11.08.22.
//

import UIKit

class CoolorsListViewController: UIViewController {
    
    let featuredCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Featured", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let randomCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Random", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let doubleRainbowCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Double Rainbow", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let coolorsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    var unsplashImages: [UnsplashImage] = []
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var categoryButtons: [UIButton] {
        return [randomCategoryButton, featuredCategoryButton, doubleRainbowCategoryButton]
    }
    
    override func loadView() {
        super.loadView()
        addAllSubViews()
        setupStackView()
        setupConstraintsTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
        activateButtons()
        searchForCategory(.photos)
        selectButton(featuredCategoryButton)
    }
    
    func addAllSubViews(){
        view.addSubview(featuredCategoryButton)
        view.addSubview(randomCategoryButton)
        view.addSubview(doubleRainbowCategoryButton)
        view.addSubview(buttonStackView)
        view.addSubview(coolorsTableView)
    }
    
    func setupStackView() {
        buttonStackView.addArrangedSubview(featuredCategoryButton)
        buttonStackView.addArrangedSubview(randomCategoryButton)
        buttonStackView.addArrangedSubview(doubleRainbowCategoryButton)
        buttonStackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
    }
    
    func setupConstraintsTableView() {
        coolorsTableView.anchor(top: buttonStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 8, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
    }
    
    func configureTableView() {
        coolorsTableView.dataSource = self
        coolorsTableView.delegate = self
        coolorsTableView.register(CoolorsTableViewCell.self, forCellReuseIdentifier: "colorCell")
        coolorsTableView.allowsSelection = false
    }
    
    func activateButtons() {
        categoryButtons.forEach{ $0.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)}
    }
    
    func searchForCategory(_ unsplashRoute: UnsplashPath) {
        UnsplashParser.shared.parseFromUnsplash(for: unsplashRoute) { (unsplashPhotos) in
            DispatchQueue.main.async {
                guard let unsplashPhotos = unsplashPhotos else { return }
                self.unsplashImages = unsplashPhotos
                self.coolorsTableView.reloadData()
            }
        }
    }
    
    func selectButton(_ button: UIButton) {
        categoryButtons.forEach{ $0.setTitleColor(UIColor.lightGray, for: .normal)}
        button.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
    }
    
    @objc func searchButtonTapped(sender: UIButton) {
        selectButton(sender)
        switch sender{
        case featuredCategoryButton:
            searchForCategory(.photos)
        case randomCategoryButton:
            searchForCategory(.photosRandom)
        case doubleRainbowCategoryButton:
            searchForCategory(.searchPhotos)
        default:
            print("Unexpected button tap")
        }
    }
    
}

extension CoolorsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpace: CGFloat = (view.frame.width - (2 * SpacingConstants.horizontalPadding))
        let titleLabelSpace: CGFloat = SpacingConstants.oneLineObjectHeight
        let colorPaletteViewSpace: CGFloat = SpacingConstants.twoLineObjectHeight
        let verticalPadding: CGFloat = (3 * SpacingConstants.verticalObjectPadding)
        let outerVerticalPadding: CGFloat = (2 * SpacingConstants.verticalPadding)
        return imageViewSpace + titleLabelSpace + colorPaletteViewSpace + verticalPadding + outerVerticalPadding
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unsplashImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! CoolorsTableViewCell
        let unsplashPhoto = unsplashImages[indexPath.row]
        cell.unsplashImage = unsplashPhoto
        return cell
    }
    
}
