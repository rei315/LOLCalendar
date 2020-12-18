//
//  LobbyController.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import NSObject_Rx
import SnapKit

class LobbyViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - Property
    
    var viewModel: LobbyViewModel!
    let tapGesture = UITapGestureRecognizer()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var touchLabel: UILabel!
    
    enum LogoUrl: String {
        case LCK = "LCK.png"
        case LPL = "LPL.png"
        case LEC = "LEC.png"
    }
    
    var logoImages: [UIImage] = []
}

extension LobbyViewController {
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
    
    // MARK: - Helpers
    
    func bindViewModel() {        
        tapGesture.rx.event.asObservable()
            .map { _ in ( Void(), self.pageControl.currentPage)
            }
            .subscribe(viewModel.input.viewDidTap)
            .disposed(by: rx.disposeBag)
        
        view.addGestureRecognizer(tapGesture)
    }
    
    func attribute() {
        logoImages.append(UIImage(named: LogoUrl.LCK.rawValue) ?? UIImage())
        logoImages.append(UIImage(named: LogoUrl.LPL.rawValue) ?? UIImage())
        logoImages.append(UIImage(named: LogoUrl.LEC.rawValue) ?? UIImage())
        
        let pageWidth = self.view.frame.width
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.contentSize = CGSize(width: CGFloat(logoImages.count) * self.view.frame.maxX, height: 0)
        
        scrollView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        logoImages.enumerated().forEach { index, image in
            let view = UIView()
            
            let imageView = UIImageView()
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            
            scrollView.addSubview(view)

            let offset = CGFloat(index) * pageWidth
            
            view.snp.makeConstraints { make in
                make.width.equalTo(pageWidth)
                make.height.equalTo(pageWidth)
                make.left.equalTo(scrollView).offset(offset)
                make.centerY.equalToSuperview()
            }
            
            imageView.snp.makeConstraints { make in
                make.width.equalTo(pageWidth/2)
                make.height.equalTo(pageWidth/2)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }
        
        touchLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        
        Observable.just(logoImages.count)
            .bind(to: pageControl.rx.numberOfPages)
            .disposed(by: rx.disposeBag)
        
        scrollView.rx.didScroll
            .withLatestFrom(scrollView.rx.contentOffset)
            .map { Int(round($0.x / pageWidth ))}
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: rx.disposeBag)
        
        
    }
}
