//
//  RosterTopCell.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/15.
//

import UIKit
import RxSwift
import Kingfisher

class RosterTopCell: UICollectionViewCell {
    // MARK: - Property
    
    typealias Data = (id: Int, acronym: String, imageURL: URL)
        
    @IBOutlet weak var imageView: UIImageView!
    
    var id: Int = 0
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Helpers
    
    func setData(data: Data) {
        imageView.kf.rx.setImage(with: data.imageURL)
        self.id = data.id
    }
}
