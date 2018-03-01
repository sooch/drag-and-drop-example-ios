//
//  ViewController.swift
//  DragAndDropExample
//
//  Created by Takashi Sou on 2018/02/28.
//  Copyright © 2018年 sooch. All rights reserved.
//

import UIKit

// @see https://qiita.com/eKushida/items/78d53d365bb69c7e7e0e
class ViewController: UIViewController {
    
    @IBOutlet var imageViews: [UIImageView]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var numbers = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numbers = loadTestData()
        addEventListner()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
    }
    
    //ダミーデータです
    private func loadTestData() -> [Int]{
        
        for i in 1...4 {
            numbers.append(i)
        }
        return numbers
    }
    
    private func addEventListner() {
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(handleLongGesture))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    //ここがポイントです
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            
        case UIGestureRecognizerState.ended:
            collectionView.endInteractiveMovement()
            
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    // Cellの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    // Cellの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.reuseIdentifier, for: indexPath) as! LabelCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuse", for: indexPath)
//        cell.number = numbers[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempNumber = numbers.remove(at: sourceIndexPath.item)
        numbers.insert(tempNumber, at: destinationIndexPath.item)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    // タップ時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard = self.storyboard
//        let secondView = storyboard?.instantiateViewController(withIdentifier: "secondView") as! SecondViewController
//        secondView.color = colors[indexPath.item]
//        secondView.colorName = colorName[indexPath.item]
//
//        present(secondView, animated: true, completion: nil)
    }
}

