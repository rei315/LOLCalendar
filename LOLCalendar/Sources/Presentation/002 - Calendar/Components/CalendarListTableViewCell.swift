//
//  CalendarListTableViewCell.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class CalendarListTableViewCell: UITableViewCell {

    typealias Data = (id: Int, scheduledAt: Date, status: Status, winnerTeam: String, firstLogoUrl: String, secondLogoUrl: String)
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var leftResultLabel: UILabel!
    @IBOutlet weak var leftTeamImage: UIImageView!
    
    @IBOutlet weak var rightResultLabel: UILabel!
    @IBOutlet weak var rightTeamImage: UIImageView!
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: Data) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateLabel.text = dateFormatter.string(from: data.scheduledAt)
        
        rightResultLabel.text = "패"
        
//        APIService.loadImage(url: URL(string: data.firstLogoUrl)!)
//            .observeOn(MainScheduler.instance)
//            .bind(to: leftTeamImage.rx.image)
//            .disposed(by: disposeBag)
//
//        APIService.loadImage(url: URL(string: data.secondLogoUrl)!)
//            .observeOn(MainScheduler.instance)
//            .bind(to: rightTeamImage.rx.image)
//            .disposed(by: disposeBag)
        leftTeamImage.translatesAutoresizingMaskIntoConstraints = false
        rightTeamImage.translatesAutoresizingMaskIntoConstraints = false
        
        leftTeamImage.kf.setImage(with: URL(string: data.firstLogoUrl)!,
                                  placeholder: nil,
                                  options: [.transition(ImageTransition.fade(1))]) { [weak self] (image, error, cacheType, imageURL) in
            self!.leftTeamImage.image = ImageUtils.resizeImage(image: image!, newWidth: self!.leftTeamImage.frame.width)
            
        }
        rightTeamImage.kf.setImage(with: URL(string: data.secondLogoUrl)!)
            
        
    }
    
    
}
