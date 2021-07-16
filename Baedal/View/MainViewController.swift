//
//  ViewController.swift
//  Baedal
//
//  Created by 박진서 on 2021/07/14.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainViewModel = MainViewModel()
    
    var currentPage: Int = 0

    @IBOutlet weak var Banner_collectionView: UICollectionView!
    @IBOutlet weak var TopView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TopView.layer.cornerRadius = 15
        bannerTimer()
        
        
        
        
    }
    
    // 2초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if currentPage == mainViewModel.bannerImgs.count-1 {
        // 맨 처음 페이지로 돌아감
            Banner_collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            currentPage = 0
            return
        }
        // 다음 페이지로 전환
        currentPage += 1
        Banner_collectionView.scrollToItem(at: NSIndexPath(item: currentPage, section: 0) as IndexPath, at: .right, animated: true)
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainViewModel.bannerImgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.BannerImg.image = mainViewModel.bannerImgs[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Banner_collectionView.frame.size.width, height: Banner_collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}


class BannerCell: UICollectionViewCell {
    @IBOutlet weak var BannerImg: UIImageView!
    
    
}
