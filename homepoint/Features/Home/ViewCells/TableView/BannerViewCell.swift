//
//  BannerViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

class BannerViewCell: UITableViewCell {
    @IBOutlet weak var sliderView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    static let identifier = "BannerViewCell"
    var imgArr = [  UIImage(named:"img-banner1"),
                    UIImage(named:"img-banner2") ,
                    UIImage(named:"img-banner3") ]
    
    var timer = Timer()
    var counter = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        sliderView.delegate = self
        sliderView.dataSource = self
        sliderView.contentInset = UIEdgeInsets.zero
        sliderView.register(
            BannerItemViewCell.nib(),
            forCellWithReuseIdentifier: "BannerItemViewCell"
        )
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        heightCollectionView.constant = (UIScreen.main.bounds.width - 40) * 145/335
    }
    
    @objc func changeImage() {
         if counter < imgArr.count {
             let index = IndexPath.init(item: counter, section: 0)
             self.sliderView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pageView.currentPage = counter
             counter += 1
         } else {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             self.sliderView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             pageView.currentPage = counter
             counter = 1
         }
     }
    
    class func nib() -> UINib { UINib(nibName: "BannerViewCell", bundle: nil) }
}

extension BannerViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerItemViewCell.identifier, for: indexPath) as? BannerItemViewCell
        cell?.img = imgArr[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
}

extension BannerViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 40)
        let height = 145 / 335 * width
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        0.0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        0.0
//    }
}
