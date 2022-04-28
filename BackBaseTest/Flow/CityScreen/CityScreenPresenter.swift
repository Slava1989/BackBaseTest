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
}

protocol CityScreenPresenterInput {
    func startIndicatorView()
    func stopIndicatorView()
    func reloadTable()
}

class CityScreenPresenter: NSObject {
    weak var viewInput: (UIViewController & CityScreenPresenterInput)?
    
    private var sortedCities: [City]?
    private var copyArray: [City]?
    private var dict: [String: [City]] = [:]
    
    private func filterArray(inputText: String, searchArray: [City]?) {
        sortedCities = []
        guard let searchArray = searchArray
        else {
            viewInput?.reloadTable()
            return
        }
        
        sortedCities = searchElements(in: searchArray, inputText: inputText)
        viewInput?.reloadTable()
    }
}

extension CityScreenPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sortedCities = sortedCities, !sortedCities.isEmpty else {
            return copyArray?.count ?? 0
        }
        
        return sortedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        guard let sortedCities = sortedCities, !sortedCities.isEmpty else {
            if let city = copyArray?[indexPath.row] {
                cell.setupCell(city: city.name, country: city.country, coordinates: city.coord)
                return cell
            }
            return UITableViewCell()
        }
        
        let city = sortedCities[indexPath.row]
        cell.setupCell(city: city.name, country: city.country, coordinates: city.coord)
        return cell
        
    }
}

extension CityScreenPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = sortedCities?[indexPath.row] else {
            return
        }
        let mapVC = MapViewController(city: city)
        viewInput?.navigationController?.pushViewController(mapVC, animated: true)
    }
}

extension CityScreenPresenter: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let inputText = textField.text,
              inputText.count > 0
        else {
            sortedCities = []
            viewInput?.reloadTable()
            return
        }
        sortedCities = copyArray
        let searchArray = dict[String(inputText.prefix(1)).lowercased()]
        filterArray(inputText: inputText, searchArray: searchArray)
    }
}

extension CityScreenPresenter: CityScreenPresenterOutput {
    func sortCities(cityArray: [City]) -> [City] {
        return cityArray.sorted {
            $0.name == $1.name ?  $0.country < $1.country : $0.name < $1.name
        }
    }
    
    func getCities(completion: @escaping () -> ()) {
        viewInput?.startIndicatorView()
        
        NetworkManeger().getCities { [weak self] cities in
            if let cities = cities {
                self?.sortedCities = self?.sortCities(cityArray: cities)
                
                DispatchQueue.main.async {
                    self?.viewInput?.stopIndicatorView()
                    self?.copyArray = self?.sortedCities
                    self?.sortedCities?.forEach { city in
                        let key = String(city.name.prefix(1).lowercased())
                        if self?.dict[key] == nil {
                            self?.dict[key] = [city]
                        } else {
                            self?.dict[key]?.append(city)
                        }
                    }
                    
                    completion()
                }
                return
            }
        }
    }
    
    func searchElements(in array: [City], inputText: String) -> [City] {
        var resultArray: [City] = []
        
        for arrayElement in array {
            if arrayElement.name.prefix(inputText.count) > inputText {
                break
            }
            
            if arrayElement.name.prefix(inputText.count) == inputText {
                resultArray.append(arrayElement)
            }
        }
        
        return resultArray
    }
}
