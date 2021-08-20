//
//  ViewController.swift
//  Random_Number
//
//  Created by Steven Worrall on 8/19/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let randomNumberInteractor = RandomNumberInteractor()
    
    let titleLabel = Label(title: "Random Number Generator!", fontSize: 24, weight: .bold)
    let randomNumberLabel = Label(title: "-", fontSize: 36, weight: .semiBold)
    let oddLabel = Label(title: "Odd", fontSize: 16, weight: .bold)
    let evenLabel = Label(title: "Even", fontSize: 16, weight: .bold)
    let oddCountLabel = Label(title: "0", fontSize: 16, weight: .semiBold)
    let evenCountLabel = Label(title: "0", fontSize: 16, weight: .semiBold)
    
    let generateButton = Button(title: "Generate!", color: .orange)
    let clearButton = Button(title: "Clear", color: .lightGray)
    
    var numberArray: [Int] = []
    var oddArray: [Int] = []
    var evenArray: [Int] = []
    var currentNumber: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.randomNumberInteractor.delegate = self
        
        self.addButtonSelectors()
        
        self.addLabels()
        self.addButtons()
    }
    
    private func addButtonSelectors() {
        self.generateButton.addTarget(self, action: #selector(self.didPressGenerate), for: .touchUpInside)
        self.clearButton.addTarget(self, action: #selector(self.didPressClear), for: .touchUpInside)
    }
    
    private func addLabels() {
        self.view.addSubview(self.oddCountLabel)
        self.oddCountLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.centerY).offset(-60)
            make.centerX.equalToSuperview().offset(-50)
        }
        self.view.addSubview(self.evenCountLabel)
        self.evenCountLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.centerY).offset(-60)
            make.centerX.equalToSuperview().offset(50)
        }
        
        self.view.addSubview(self.oddLabel)
        self.oddLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.oddCountLabel.snp.top).offset(-8)
            make.centerX.equalTo(self.oddCountLabel.snp.centerX)
        }
        self.view.addSubview(self.evenLabel)
        self.evenLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.evenCountLabel.snp.top).offset(-8)
            make.centerX.equalTo(self.evenCountLabel.snp.centerX)
        }
        self.view.addSubview(self.randomNumberLabel)
        self.randomNumberLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.oddLabel.snp.top).offset(-50)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(70)
            make.centerX.equalToSuperview()
        }
    }
    
    private func addButtons() {
        self.view.addSubview(self.generateButton)
        self.generateButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.centerY).offset(80)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(self.clearButton)
        self.clearButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.generateButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func didPressGenerate() {
        self.randomNumberInteractor.getRandomNumber()
    }
    
    @objc func didPressClear() {
        self.numberArray = []
        self.evenArray = []
        self.oddArray = []
        self.currentNumber = nil
        
        self.randomNumberLabel.text = "-"
        self.oddCountLabel.text = "0"
        self.evenCountLabel.text = "0"
    }
    
    private func generateLocally() {
        self.updateWith(num: self.generateRandomNumber())
    }
    
    private func determineNumberPlace() {
        if let num = self.currentNumber {
            if num % 2 == 0 {
                self.evenArray.append(num)
                self.evenCountLabel.text = String(self.evenArray.count)
            } else {
                self.oddArray.append(num)
                self.oddCountLabel.text = String(self.oddArray.count)
            }
        }
    }
    
    private func updateWith(num: Int) {
        self.currentNumber = num
        
        if let num = self.currentNumber {
            self.numberArray.append(num)
            self.randomNumberLabel.text = String(num)
        }
        
        self.determineNumberPlace()
    }

    private func generateRandomNumber() -> Int {
        let randomInt = Int.random(in: 0..<101)
        
        return randomInt
    }
}

extension ViewController: RandomNumberInteractorDelegate {
    func didRecieveRandomNumber(data: Int) {
        DispatchQueue.main.async {
            self.updateWith(num: data)
        }
    }
    
    func didRecieveError() {
        // On error case we can just geenrate locally
        DispatchQueue.main.async {
            self.presentAlert(title: "Error retrieving number from API.", message: "Wil generate locally.")
            self.generateLocally()
        }
    }
}
