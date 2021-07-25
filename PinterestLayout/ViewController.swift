//
//  ViewController.swift
//  PinterestLayout
//
//  Created by quangthai206 on 25/07/2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    let testData = [
        User(username: "Pasccon", imageURL: "https://avatars.githubusercontent.com/u/2911931?v=4"),
        User(username: "Rivera", imageURL: "https://avatars.githubusercontent.com/u/1261982?v=4"),
        User(username: "Sandoval", imageURL: "https://avatars.githubusercontent.com/u/5307015?v=4"),
        User(username: "David", imageURL: "https://avatars.githubusercontent.com/u/6173704?v=4"),
        User(username: "Alex", imageURL: "https://avatars.githubusercontent.com/u/204671?v=4"),
        User(username: "Rivera", imageURL: "https://avatars.githubusercontent.com/u/1261982?v=4"),
        User(username: "Pasccon", imageURL: "https://avatars.githubusercontent.com/u/2911931?v=4"),
        User(username: "Rivera", imageURL: "https://avatars.githubusercontent.com/u/1261982?v=4"),
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nibCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "CollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.titleView.text = testData[indexPath.item].username
        cell.imageView.sd_setImage(with: URL(string: testData[indexPath.item].imageURL))
        
        cell.layer.cornerRadius = cell.frame.width/2
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func changeTabBar(hidden:Bool, animated: Bool){
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        let frame = tabBar.frame
        let offset = hidden ? frame.size.height : -frame.size.height
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: { (true) in
            tabBar.isHidden = hidden
        })
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)
            self.changeTabBar(hidden: true, animated: true)
            
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                print("Unhide")
            }, completion: nil)
            self.changeTabBar(hidden: false, animated: true)
        }
    }
}
