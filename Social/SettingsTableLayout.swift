//
//  SettingsTableVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/11/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import Foundation
import UIKit

// This Sets up the sticky header
class SettingsTableLayout: UICollectionViewFlowLayout {
    
    /// Specifies the z index of the supplementary view so that they can on top of cells and decoration views
    private let stickyHeaderZIndex = 1
    
    /// stores the sticky header indexpaths
    private var stickyHeaderIndexPaths = [NSIndexPath]()
    
    // MARK - UICollectionViewLayout method overrides
    override func prepareLayout()  {
        super.prepareLayout()
        
        // Identifies all the section which needs a sticky supplementary header view.
        stickyHeaderIndexPaths.removeAll(keepCapacity: false)
        if let numberOfSections = collectionView?.numberOfSections() {
            for index in 0 ..< numberOfSections {
                var indexPath = NSIndexPath(forItem: 0, inSection: index)
                stickyHeaderIndexPaths.append(indexPath)
            }
        }
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        // For every change in bounds we need to invalidate the layout, so that we can override the
        // supplementary frame attribute
        return true
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        // In layoutAttributesForElementsInRect, we need to get the indexpaths within the rect
        // and add all header indexPath
        var attributesInRect = super.layoutAttributesForElementsInRect(rect)
        var updatedAttributesInRect = [UICollectionViewLayoutAttributes]()
        
        if let attributes = attributesInRect {
            for obj in attributes {
                let attribute = obj as! UICollectionViewLayoutAttributes
                let attributeIndexPath = attribute.indexPath
                
                if attribute.representedElementCategory == .Cell {
                    updatedAttributesInRect.append(attribute)
                }
            }
        }
        
        for indexPath in stickyHeaderIndexPaths {
            let headerAttribute = layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath)
            updatedAttributesInRect.append(headerAttribute)
        }
        
        // Returning attributes for cell and all sticky supplmentary header views
        return updatedAttributesInRect
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let layoutAttribute  = super.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: indexPath)
        let contentOffset = collectionView?.contentOffset ?? CGPointZero
        var nextHeaderOrigin = CGPointZero
        var nextHeaderIndex : Int = 0
        
        // Get the layout attribute of next supplementary index and use that to modify current header view
        // to get the next header pushing out the current sticky header
        if (indexPath.section + 1 < collectionView?.numberOfSections()) {
            nextHeaderIndex = indexPath.section + 1
            let nextIndexPath = NSIndexPath(forItem: 0, inSection: nextHeaderIndex)
            var nextHeaderFrame = super.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: nextIndexPath).frame
            nextHeaderOrigin = nextHeaderFrame.origin
        }
        else {
            return layoutAttribute;
        }
        
        // Override header origin
        var headerFrame = layoutAttribute.frame
        if (scrollDirection == UICollectionViewScrollDirection.Vertical) {
            var nextStickyCellY = nextHeaderOrigin.y - headerFrame.size.height
            var currentStickyCellY = max(contentOffset.y, headerFrame.origin.y)
            headerFrame.origin.y = min(currentStickyCellY, nextStickyCellY)
        }
        else {
            var nextStickyCellX = nextHeaderOrigin.x - headerFrame.size.width
            var currentStickyCellX = max(contentOffset.x, headerFrame.origin.x)
            headerFrame.origin.x = min(currentStickyCellX, nextStickyCellX)
        }
        
        // Set the zIndex of the supplementary view so that it can stay on top of other elements in collection view
        layoutAttribute.zIndex = stickyHeaderZIndex
        layoutAttribute.frame = headerFrame
        return layoutAttribute
    }
    
}
