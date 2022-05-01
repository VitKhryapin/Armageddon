//
//  NetworkService.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getObjects(completion: @escaping (Result<ClosestAsteroidsRoot?, Error>) -> ())
    var countDay: Int {get set}
}

class NetworkService: NetworkServiceProtocol {
    var countDay = 0
    
    func getObjects(completion: @escaping (Result<ClosestAsteroidsRoot?, Error>) -> ()) {
        let date = Calendar.current.date(byAdding: .day, value: countDay, to: Date())?.getFormattedDateToLoad()
        guard date != nil else { return }
        let urlString = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(date!)&end_date=\(date!)&api_key=UbQeQcEjN6KHtKwIye7wjyVT5UKgrbF5XqwKYgHO"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(ClosestAsteroidsRoot.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


