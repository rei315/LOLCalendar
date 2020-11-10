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

    typealias Data = (scheduleAt: Date, winnner: Int, opponents: [OpponentTeam], score: [Int:Int])
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var leftResultLabel: UILabel!
    @IBOutlet weak var leftTeamImage: UIImageView!
    
    @IBOutlet weak var rightResultLabel: UILabel!
    @IBOutlet weak var rightTeamImage: UIImageView!
    
    let disposeBag = DisposeBag()
    
    enum Result: String {
        case Win = "승"
        case Defeat = "패"
    }
    
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
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateLabel.text = dateFormatter.string(from: data.scheduleAt)
        leftResultLabel.text = ""
        let left = data.opponents.first
        let right = data.opponents.last
        // Result
        leftResultLabel.text = Result.Defeat.rawValue
        rightResultLabel.text = Result.Defeat.rawValue
        leftResultLabel.textColor = .red
        rightResultLabel.textColor = .red
        if (data.winnner == left?.id){
            leftResultLabel.text = Result.Win.rawValue
            leftResultLabel.textColor = .blue
        } else {
            rightResultLabel.text = Result.Win.rawValue
            rightResultLabel.textColor = .blue
        }
        
        // Logo Image
        leftTeamImage.translatesAutoresizingMaskIntoConstraints = false
        rightTeamImage.translatesAutoresizingMaskIntoConstraints = false
        leftTeamImage.kf.setImage(with: URL(string: left!.logoURL)!)
//        leftTeamImage.kf.setImage(with: URL(string: left!.logoURL)!,
//                                  placeholder: nil,
//                                  options: [.transition(ImageTransition.fade(1))]) { [weak self] (image, error, cacheType, imageURL) in
//            self!.leftTeamImage.image = ImageUtils.resizeImage(image: image!, newWidth: self!.leftTeamImage.frame.width)
//        }
        rightTeamImage.kf.setImage(with: URL(string: right!.logoURL)!)
//        rightTeamImage.kf.setImage(with: URL(string: right!.logoURL)!,
//                                   placeholder: nil,
//                                   options: [.transition(ImageTransition.fade(1))]) { [weak self] (image, error, cacheType, imageURL) in
//             self!.rightTeamImage.image = ImageUtils.resizeImage(image: image!, newWidth: self!.rightTeamImage.frame.width)
//        }
//    }
    
    }
}
