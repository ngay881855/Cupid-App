//
//  ViewController.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/25/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var cardsContentView: UIView!
    @IBOutlet private weak var loadDataActivityIndicator: UIActivityIndicatorView!
    
    var model: CupidViewModel?
    //var personView: PersonView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.bringSubviewToFront(loadDataActivityIndicator)
        self.loadDataActivityIndicator.startAnimating()
        model = CupidViewModel(delegate: self)
        model?.reloadData()
    }
    
    @IBAction private func reloadData(_ sender: Any) {
        model?.reloadData()
    }
}

extension ViewController: CupidViewModelDelegate {
    func startActivityIndicator() {
        self.loadDataActivityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.loadDataActivityIndicator.stopAnimating()
    }

    var bounds: CGRect {
        return self.cardsContentView.bounds
    }
    
    func addView(with view: PersonView) {
        self.cardsContentView.insertSubview(view, at: 0)
    }
    
    func removeView(_ view: PersonView) {
        view.removeFromSuperview()
    }
    
    func failed(error: CustomError) {
        print(error)
    }
}
