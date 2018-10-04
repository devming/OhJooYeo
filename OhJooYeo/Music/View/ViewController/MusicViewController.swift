//
//  PraiseViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scoreOnOff: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        guard let url = URL(string: "http://ec2-52-79-233-2.ap-northeast-2.compute.amazonaws.com:8080/OhJooYeoMVC/img/TestImage.jpg") else {
//            print("ERR")
//            return
//        }
//        
//        guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
//            return
//        }
//        self.scoreImageView.image = image
//        print("@@")
    }

    @IBAction func scoreSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            
        }
    }
}

extension MusicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.cellName, for: indexPath) as? MusicCollectionViewCell else {
            return UICollectionViewCell()
        }
//        cell.scoreImageView.image = 
        return cell
    }
}

extension MusicViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
