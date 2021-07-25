//
//  PinterestLayout.swift
//  PinterestLayout
//
//  Created by quangthai206 on 25/07/2021.
//

import UIKit

class PinterestLayout: UICollectionViewLayout {
    
    private let numberOfColumns = 2
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }
        
        let columnWidth = contentWidth * 0.44
        
        let xOffset: [CGFloat] = [0.0, collectionView.bounds.width * 0.54]
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        var column = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let randomHeight = item == 0 ? 0 : CGFloat.random(in: (columnWidth/2 - 10)...(columnWidth/2 + 10))
            
            let frame = CGRect(x: xOffset[column] + (column == 0 ? CGFloat(Int.random(in: -15...20)) : CGFloat(Int.random(in: 0...30))),
                               y: yOffset[column] + randomHeight,
                               width: columnWidth,
                               height: columnWidth)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + columnWidth + randomHeight
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect)
    -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
    -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}


