//
//  AsteroidTableViewCell.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import UIKit

class AsteroidTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var diametrLabel: UILabel!
    @IBOutlet weak var closeApproachDateLabel: UILabel!
    @IBOutlet weak var isPotentiallyHazardousAsteroidLabel: UILabel!
    @IBOutlet weak var missDistanceLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var imageAsteroids: UIImageView!
    
    var presenter: MainPresenterProtocol!
    var buttonAction: ((UIButton) -> Void)?
    var distanceString = ""
   
    override func awakeFromNib() {
        super.awakeFromNib()
        trashButton.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        settingsConstraintAsteroidImage()
    }
    
    func settingsConstraintAsteroidImage() {
        for heightConstraint in self.imageAsteroids.constraints {
            if heightConstraint.firstAttribute == .height {
                self.imageAsteroids.removeConstraint(heightConstraint)
            }
        }
        for widthConstraint in imageAsteroids.constraints {
            if widthConstraint.firstAttribute == .width {
                self.imageAsteroids.removeConstraint(widthConstraint)
            }
        }
    }
    
    func settings(presenters: MainPresenterProtocol, indexPath: IndexPath) -> AsteroidTableViewCell {
        presenter = presenters
        let cell = settigsCell(indexPath)
        return cell
    }
    
    func settigsCell(_ indexPath: IndexPath) -> AsteroidTableViewCell {
        let name = presenter.filterAsteroidsList[indexPath.section].name.getFormatName()
        let date = presenter.filterAsteroidsList[indexPath.section].closeApproachData[0].closeApproachDate.getFormattedDate()
        let diametr = Int(presenter.filterAsteroidsList[indexPath.section].estimatedDiameter.meters.estimatedDiameterMax)
        let gradeDanger = presenter.filterAsteroidsList[indexPath.section].isPotentiallyHazardousAsteroid ? "опасен" : "не опасен"
        
        if Filter.shared.currentSettings.unit == 0 {
            distanceString = presenter.filterAsteroidsList[indexPath.section].closeApproachData[0].missDistance.kilometers
            missDistanceLabel.text = "на расстояние \(distanceString.getFormattedDistance()) км"
        } else {
            distanceString = presenter.filterAsteroidsList[indexPath.section].closeApproachData[0].missDistance.lunar
            missDistanceLabel.text = "на расстояние \(distanceString.getFormattedDistance()) л. орб."
        }
        
        nameLabel.text = name
        diametrLabel.text = "Диаметр: \(diametr) м"
        closeApproachDateLabel.text = "Подлетает \(date)"
        isPotentiallyHazardousAsteroidLabel.text = gradeDanger
        if isPotentiallyHazardousAsteroidLabel.text == "опасен" {
            isPotentiallyHazardousAsteroidLabel.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        } else {
            isPotentiallyHazardousAsteroidLabel.textColor = .black
        }
        
        settingsGradient(indexPath)
        settingsAsteroids(indexPath)
        return self
    }
    
    func settingsGradient(_ indexPath: IndexPath) {
        if presenter.filterAsteroidsList[indexPath.section].isPotentiallyHazardousAsteroid {
            self.gradientView.gradientLayer.colors = [
                UIColor(red: 1, green: 0.694, blue: 0.6, alpha: 1).cgColor,
                UIColor(red: 1, green: 0.031, blue: 0.267, alpha: 1).cgColor
            ]
        } else {
            self.gradientView.gradientLayer.colors = [
                UIColor(red: 0.811, green: 0.952, blue: 0.491, alpha: 1).cgColor,
                UIColor(red: 0.492, green: 0.908, blue: 0.549, alpha: 1).cgColor
            ]
        }
        self.gradientView.updateGradient()
    }
    
    func settingsAsteroids(_ indexPath: IndexPath) {
        let diametr = Int(presenter.filterAsteroidsList[indexPath.section].estimatedDiameter.meters.estimatedDiameterMax)
        self.imageAsteroids.widthAnchor.constraint(equalToConstant: CGFloat(diametr / 5)).isActive = true
        self.imageAsteroids.heightAnchor.constraint(equalToConstant: CGFloat(diametr / 5)).isActive = true
    }
    
    @IBAction func trashButtonAction(_ sender: UIButton) {
        self.buttonAction?(sender)
    }
}


