//
//  RoverPhotosViewController.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 14/08/2019.
//  Copyright © 2019 artem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RoverPhotosViewController: UIViewController, StoryboardInitializable {

    @IBOutlet weak var photosTableView: UITableView!
    private let disposeBag = DisposeBag()
    
    var viewModel: RoverPhotosViewModeling?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    private func setUpTable() {
        viewModel?.photos.bind(to: photosTableView.rx.items(cellIdentifier: "PhotoTableViewCell", cellType: PhotoTableViewCell.self)) { _, model, cell in
            cell.photo = model.self
        }.disposed(by: disposeBag)
        
        photosTableView.rx.modelSelected(RoverPhoto.self)
            .subscribe({ [weak self] rover in
                if let rover = rover.element {
                    self?.viewModel?.didSelectImage(rover.photoUrl)
                }
            }).disposed(by: disposeBag)
        
        photosTableView.rx.willDisplayCell
            .subscribe(onNext: {[weak self] cell, indexPath in
                if indexPath.row - 1 == self?.viewModel?.imagesPerPage {
                    self?.viewModel!.loadMorePhotos()
                }
            })
            .disposed(by: disposeBag)
    }

}
