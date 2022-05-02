//
//  CityScreenPresenter.swift
//  BackBaseTest
//
//  Created by Veaceslav Chirita on 27.04.2022.
//

import UIKit

protocol CityScreenPresenterOutput {
    func getCities(completion: @escaping () -> ())
    func sortCities(cityArray: [City]) -> [City]
    func searchElements(in array: [City], inputText: String) -> [City]
    func filterArray(inputText: String, searchArray: [City]?)
}

protocol CityScreenPresenterInput {
    var sortedCities: [City] { get set }
    var copyArray: [City] { get set }
    var dict: [String: [City]] { get set }
    
    func startIndicatorView()
    func stopIndicatorView()
    func reloadTable()
    func updateEmptyView(hideTable: Bool, hideMessage: Bool)
}

class CityScreenPresenter: NSObject {
    weak var viewInput: (UIViewController & CityScreenPresenterInput)?
    
}

extension CityScreenPresenter: CityScreenPresenterOutput {
    func sortCities(cityArray: [City]) -> [City] {
        return cityArray.sorted {
            $0.name == $1.name ?  $0.country < $1.country : $0.name < $1.name
        }
    }
    
    func getCities(completion: @escaping () -> ()) {
        viewInput?.startIndicatorView()
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            let cities = NetworkManager().loadJsonFromFile()
            
            if let cities = cities {
                self.viewInput?.sortedCities = self.sortCities(cityArray: cities)
                DispatchQueue.main.async {
                    self.viewInput?.stopIndicatorView()
                    
                    let sortedCities = self.viewInput?.sortedCities ?? []
                    
                    self.viewInput?.copyArray = sortedCities
                    sortedCities.forEach { city in
                        let key = String(city.name.prefix(1).lowercased())
                        if self.viewInput?.dict[key] == nil {
                            self.viewInput?.dict[key] = [city]
                        } else {
                            self.viewInput?.dict[key]?.append(city)
                        }
                    }
                    completion()
                }
            }
        }
    }
    
    func searchElements(in array: [City], inputText: String) -> [City] {
        var resultArray: [City] = []
        
        var leftIndex = 0
        var rightIndex = array.count - 1

        while (leftIndex <= rightIndex) {
            if array[leftIndex].name.prefix(inputText.count) > inputText ||
                array[rightIndex].name.prefix(inputText.count) < inputText {
                break
            }
            
            if leftIndex == rightIndex {
                resultArray.append(array[leftIndex])
                break
            }
            
            if array[leftIndex].name.prefix(inputText.count) < inputText {
                leftIndex += 1
            } else if array[leftIndex].name.prefix(inputText.count) == inputText {
                resultArray.append(array[leftIndex])
                leftIndex += 1
            }
            
            if array[rightIndex].name.prefix(inputText.count) > inputText {
                rightIndex -= 1
            } else if array[rightIndex].name.prefix(inputText.count) == inputText {
                resultArray.append(array[rightIndex])
                rightIndex -= 1
            }
        }
        
        return sortCities(cityArray: resultArray)
    }
    
    func filterArray(inputText: String, searchArray: [City]?) {
        viewInput?.sortedCities = []
        viewInput?.updateEmptyView(hideTable: false, hideMessage: true)
        guard let searchArray = searchArray
        else {
            viewInput?.reloadTable()
            viewInput?.updateEmptyView(hideTable: true, hideMessage: false)
            return
        }
        
        let resultArray = searchElements(in: searchArray, inputText: inputText)
        
        guard !resultArray.isEmpty else {
            viewInput?.updateEmptyView(hideTable: true, hideMessage: false)
            return
        }
        
        viewInput?.sortedCities = resultArray
        viewInput?.reloadTable()
    }
}
