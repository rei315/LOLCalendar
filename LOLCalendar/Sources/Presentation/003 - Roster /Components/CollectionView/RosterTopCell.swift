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

    typealias Data = (id: Int, acronym: String, imageURL: String)
        
    @IBOutlet weak var imageView: UIImageView!
    
    var id: Int = 0
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data: Data) {
        print(data.acronym)
        imageView.kf.rx.setImage(with: URL(string: data.imageURL)!)
        self.id = data.id
    }
}
