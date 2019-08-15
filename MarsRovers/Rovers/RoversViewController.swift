//
//  ViewController.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 13/08/2019.
//  Copyright © 2019 artem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RoversViewController: UIViewController, StoryboardInitializable {
    @IBOutlet weak var cameraTextField: UITextField!
    @IBOutlet weak var roverTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var showPhotosButton: UIButton!
    
    var viewModel: RoverViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        createRoverPicker()
        createRoverCameras()
        createDatePicker()
        
        setUpSearchButton()
        
        cameraTextField.rx.text.orEmpty.bind(to: viewModel!.cameraText).disposed(by: disposeBag)
        roverTextField.rx.text.orEmpty.bind(to: viewModel!.roverText).disposed(by: disposeBag)
        dateTextField.rx.text.orEmpty.bind(to: viewModel!.dateText).disposed(by: disposeBag)
    }
    
    private func setUpSearchButton() {
        showPhotosButton.rx.tap.subscribe({_ in
            self.viewModel?.openSelectedRover()
        }).disposed(by: disposeBag)
        
        viewModel?.isParametersValid
            .subscribe(onNext: { isValid in
            self.showPhotosButton.isEnabled = isValid ? true : false
            self.showPhotosButton.alpha = isValid ? 1 : 0.25
        }).disposed(by: disposeBag)
    }

    private func createRoverPicker() {
        
        let roverPicker = UIPickerView()
        roverTextField.inputView = roverPicker
        
        viewModel?.roversData.bind(to: roverPicker.rx.itemTitles) { $1.name }
            .disposed(by: disposeBag)
        
        roverPicker.rx.modelSelected(Rover.self)
            .subscribeOn(MainScheduler())
            .subscribe(onNext: { rovers in
                guard let rover = rovers.first else {return}
                self.viewModel?.rover.onNext(rover)
            })
            .disposed(by: disposeBag)
        
        viewModel?.rover
            .map({ $0.name })
            .bind(to: roverTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func createRoverCameras() {
        let cameraPicker = UIPickerView()
        viewModel?.rover
            .map({ $0.cameras})
            .bind(to: cameraPicker.rx.itemTitles) { (first, second) in
                return second.rawValue
            }.disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel!.rover, cameraPicker.rx.itemSelected) { rover, items in
                return "\(rover.cameras[items.row])"
            }.subscribeOn(MainScheduler()).bind(to: cameraTextField.rx.text)
            .disposed(by: disposeBag)
        
        cameraTextField.inputView = cameraPicker
    }
    
    private func createDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.rx.date.map { formatter.string(from: $0) }
            .bind(to: self.dateTextField.rx.text)
            .disposed(by: disposeBag)
        
        dateTextField.inputView = datePicker
        dateTextField.text = ""
    }
}







