//
//  DetailViewMOdel.swift
//  AccionParser
//
//  Created by Anshuman Dahale on 20/11/22.
//

import Foundation

protocol DetailViewModelProtocol {
    var item: Item { get }
    var outputDelegate: DetailViewModelOutput? { get set }
    func viewLoaded()
}
protocol DetailViewModelOutput {
    func showItemDetails(tags: String)
}

class DetailViewModel: DetailViewModelProtocol {
    var item: Item
    var outputDelegate: DetailViewModelOutput?
    
    init(item: Item) {
        self.item = item
    }
    
    func viewLoaded() {
        guard let arr = self.item.tags else { return }
        let str = arr.joined(separator: "\n")
        outputDelegate?.showItemDetails(tags: str)
    }
}
