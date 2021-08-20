//
//  RandomNumberInteractor.swift
//  Random_Number
//
//  Created by Steven Worrall on 8/19/21.
//

import Foundation

protocol RandomNumberInteractorDelegate: class {
    func didRecieveRandomNumber(data: Int)
    func didRecieveError()
}

class RandomNumberInteractor {
    private let randomNumberRepo = RandomNumberRepository()
    public var delegate: RandomNumberInteractorDelegate?
    
    public func getRandomNumber() {
        self.randomNumberRepo.fetchItunesDataWithResults {
            [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.didRecieveRandomNumber(data: data)
            case .failure(_):
                // You could pass your error along here and do something specific for each case.
                self.delegate?.didRecieveError()
            }
        }
    }
}
