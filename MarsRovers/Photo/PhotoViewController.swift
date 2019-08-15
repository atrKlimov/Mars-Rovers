//
//  PhotoViewController.swift
//  MarsRovers
//
//  Created by Artem Klimov on 13/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController, StoryboardInitializable, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: PhotoViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: viewModel!.imageURL) {
            imageView.kf.setImage(with: url)
        }

        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }


}
