//
//  RandomNumberRepository.swift
//  Random_Number
//
//  Created by Steven Worrall on 8/19/21.
//

import Foundation

enum APIError: Error {
    case URL
    case Response
    case Cast
}

class RandomNumberRepository {
    private let urlString = "https://www.random.org/integers/?num=1&min=0&max=101&col=1&base=10&format=plain&rnd=new"

    public func fetchItunesDataWithResults(completion: @escaping (Result<Int, APIError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.URL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let _ = err {
                completion(.failure(.Response))
                return
            }
            
            guard let data = data else {
                completion(.failure(.Cast))
                return
            }
            
            if let stringData = String(data: data, encoding: .utf8){
                // data from API has a newline att he end
                let filteredString = String(stringData.filter { !" \n\t\r".contains($0) })
                if let intData = Int(filteredString) {
                    completion(.success(intData))
                    return
                } else {
                    completion(.failure(.Cast))
                    return
                }
            } else {
                completion(.failure(.Cast))
                return
            }
            
        }.resume()
    }
}
