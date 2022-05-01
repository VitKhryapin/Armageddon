//
//  Alert.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 29.04.2022.
//

import Foundation
import UIKit


class Alert {
    
    var presenter: MainPresenterProtocol!
    
    func alertDetail (asteroid: NearEarthObject, indexPath: IndexPath, completionHandler: @escaping (NearEarthObject) -> Void ) -> UIAlertController {
        let distance = Filter.shared.currentSettings.unit == 0 ? asteroid.closeApproachData[0].missDistance.kilometers.getFormattedDistance() : asteroid.closeApproachData[0].missDistance.lunar.getFormattedDistance()
        
        let alert = UIAlertController(title: asteroid.name.getFormatName(),
                                      message:
            """
            Диаметр: \(Int(asteroid.estimatedDiameter.meters.estimatedDiameterMax)) м
            Дата подлета: \(asteroid.closeApproachData[0].closeApproachDate.getFormattedDate())
            Расстояние: \(distance) \(Filter.shared.currentSettings.unit == 0 ? "км" : "л. орб.")
            Скорость: \(asteroid.closeApproachData[0].relativeVelocity.kilometersPerHour.getFormattedDistance()) км/ч
            Орбитальное тело: \(asteroid.closeApproachData[0].orbitingBody)
            Оценка: \(asteroid.isPotentiallyHazardousAsteroid ? "опасен" : "не опасен")
            """
                                      ,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Уничтожить", style: .destructive) { _ in
            completionHandler(asteroid)
        })
        return alert
    }
    
    func secondAlertDetail (asteroid: NearEarthObject, indexPath: IndexPath ) -> UIAlertController {
        let distance = Filter.shared.currentSettings.unit == 0 ? asteroid.closeApproachData[0].missDistance.kilometers.getFormattedDistance() : asteroid.closeApproachData[0].missDistance.lunar.getFormattedDistance()
        
        let alert = UIAlertController(title: asteroid.name.getFormatName(),
                                      message:
            """
            Диаметр: \(Int(asteroid.estimatedDiameter.meters.estimatedDiameterMax)) м
            Дата подлета: \(asteroid.closeApproachData[0].closeApproachDate.getFormattedDate())
            Расстояние: \(distance) \(Filter.shared.currentSettings.unit == 0 ? "км" : "л. орб.")
            Скорость: \(asteroid.closeApproachData[0].relativeVelocity.kilometersPerHour.getFormattedDistance()) км/ч
            Орбитальное тело: \(asteroid.closeApproachData[0].orbitingBody)
            Оценка: \(asteroid.isPotentiallyHazardousAsteroid ? "опасен" : "не опасен")
            """
                                      ,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    func goToTheBruceCommand() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Командой им. Брюса Уилиса уничтоженны все выбранные астероиды", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Мы спасены!", style: .cancel, handler: nil))
        let constraintWidth = NSLayoutConstraint(
           item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
           NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        alert.view.addConstraint(constraintWidth)
       
        let imgViewBruce = UIImageView(frame: CGRect(x: 0, y: -200, width: 240, height:  200))
        imgViewBruce.image = UIImage(named:"bruce.jpeg")
        imgViewBruce.layer.cornerRadius = 10
        imgViewBruce.clipsToBounds = true
        imgViewBruce.center.x = constraintWidth.constant / 2
        alert.view.addSubview(imgViewBruce)
        return alert
    }
    
    func erorrNetwork () -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка сети", message: "Проверьте подключение к интернету. \nВозможно астеройд уже близко", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
        return alert
    }
}



