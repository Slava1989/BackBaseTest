//
//  CityScreenBuilder.swift
//  BackBaseTest
//
//  Created by Veaceslav Chirita on 28.04.2022.
//

import UIKit

class CityScreenBuilder {
    static func build() -> (UIViewController & CityScreenPresenterInput) {
        let presenter = CityScreenPresenter()
        let viewController = CitiesViewController(presenter: presenter)
        
        presenter.viewInput = viewController
        return viewController
    }
        
}
