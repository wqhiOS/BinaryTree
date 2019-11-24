//
//  BinaryBalanceTree.swift
//  BinaryTree
//
//  Created by 吴启晗 on 2019/11/24.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import Cocoa

class BinaryBalanceTree<Element: Comparable>: BinarySearchTree<Element> {
    func rotateLeft(node grand: Node<Element>) {
        
        let parent = grand.right
        let parent_left = parent?.left
        
        if grand.isleftChild {
            grand.parent?.left = parent
        }else if grand.isRightChild {
            grand.parent?.right = parent
        }else {
            root = parent
        }
        
        parent?.left = grand //1
        parent?.parent = grand.parent
        grand.parent = parent
        
        grand.right = parent_left//2. 右旋和左旋就1.2两行不一样，可以抽出啦
        parent_left?.parent = grand
        
        grand.updateHeight()
        parent?.updateHeight()
        
    }
    func rotateRight(node grand: Node<Element>) {
        let parent = grand.left
        let parent_right = parent?.right
        
        if grand.isleftChild {
            grand.parent?.left = parent
        }else if grand.isRightChild {
            grand.parent?.right = parent
        }else {
            root = parent
        }
        
        parent?.right = grand
        parent?.parent = grand.parent
        grand.parent = parent
        
        grand.left = parent_right
        parent_right?.parent = grand
        
        grand.updateHeight()
        parent?.updateHeight()
    }
}
