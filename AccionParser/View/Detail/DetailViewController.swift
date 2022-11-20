//
//  DetailViewController.swift
//  AccionParser
//
//  Created by Anshuman Dahale on 17/11/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var tags: UILabel!
    var viewModel: DetailViewModelProtocol
    init(viewModel: DetailViewModelProtocol, nib: String) {
        self.viewModel = viewModel
        super.init(nibName: nib, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tags"
        viewModel.outputDelegate = self
        viewModel.viewLoaded()
    }
}

extension DetailViewController: DetailViewModelOutput {
    func showItemDetails(tags: String) {
        self.tags.text = tags
    }
}
