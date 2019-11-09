//
//  ImageOptimizedViewController.swift
//  TableViewPerformanceOptimizationDemo
//
//  Created by wuqh on 2019/11/9.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class ImageOptimizedViewController: UIViewController {
    
    var imageCacheList = [Int:UIImage]()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: CollectionCell.height, height: CollectionCell.height)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.description())
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
    }

}

extension ImageOptimizedViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.description(), for: indexPath) as! CollectionCell
        cell.tag = 1000+indexPath.row
        cell.imageView.image = nil
        
        if let image = self.imageCacheList[indexPath.row] {
            cell.imageView.image = image
        }else {
            DispatchQueue.global().async {
                let url = Bundle.main.url(forResource: "\(indexPath.row + 1)", withExtension: "jpg")!
                let size = CGSize(width: 500, height: 500)
                let image = CoreGraphics.resizedImage(at: url, for: size)
//                let image = UIImage(contentsOfFile: url.path)
                if let _image = image {
                    self.imageCacheList[indexPath.row] = _image
                    DispatchQueue.main.async {
                        if cell.tag == 1000+indexPath.row {
                            cell.imageView.image = _image
                        }
                    }
                }else {
                    //error
                    
                }
            }
        }
        return cell
    }
}

enum CoreGraphics {
    static func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        precondition(size != .zero)

        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            return nil
        }
        
        let context = CGContext(data: nil,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: image.bitsPerComponent,
                                bytesPerRow: image.bytesPerRow,
                                space: image.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!,
                                bitmapInfo: image.bitmapInfo.rawValue)
        context?.interpolationQuality = .high
        context?.draw(image, in: CGRect(origin: .zero, size: size))
        
        guard let scaledImage = context?.makeImage() else { return nil }
        
        return UIImage(cgImage: scaledImage)
    }
}

enum UIKit {
    @available(iOS 10.0, *)
    static func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

class CollectionCell: UICollectionViewCell {
    
    static var height: CGFloat = (UIScreen.main.bounds.width - 40)
    
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.frame = bounds
        imageView.backgroundColor = UIColor.lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
