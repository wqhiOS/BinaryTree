//
//  AVLTree.swift
//  二叉树
//
//  Created by wuqh on 2019/11/21.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import Foundation

/// 平衡二叉树(我们常说的平衡二叉树一般指的都是AVL树)
class AVLTree<Element: Comparable>: BinarySearchTree<Element> {
    
    /// 添加节点之后
    /// 1.如果平衡就从节点到父节点往上更新高度(高度是否会变化不好说啊)
    /// 2.如果不平衡，就恢复平衡，并且也要更新高度
    /// - Parameter node: Node
    override func afterAdding(_ node: Node<Element>) {
        var parent = node.parent
        while parent != nil {
            if parent!.isBalance {
                parent!.updateHeight()
            }else {
                restoreBalance(node: parent!)
                break //不平衡是因为 平衡因子=2，那说明之前平衡因子肯定是1， 所以恢复平衡后，平衡因子就会变为1，就变回了添加之前，所以它往上的父节点都可以不再处理了。
            }
            parent = parent!.parent
        }
    }
    
    private func restoreBalance(node grand: Node<Element>) {
        //因为添加节点，一旦出现失衡，不可能导致父节点失衡，所以 parent肯定存在 同样node也肯定存在
        let parent = grand.tallerChild!
        let node = parent.tallerChild!
        if parent.isleftChild {
            if node.isleftChild {//LL
                rotateRight(node: grand)
            }else {//LR
                rotateLeft(node: parent)
                rotateRight(node: grand)
            }
        }else {
            if node.isRightChild {//RR
                rotateLeft(node: grand)
            }else {//RL
                rotateRight(node: parent)
                rotateLeft(node: grand)
            }
        }
    }
    
    private func rotateLeft(node grand: Node<Element>) {
        
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
    private func rotateRight(node grand: Node<Element>) {
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


extension Node {
    
    var isBalance: Bool {
        let leftHeight = left?.height ?? 0
        let rightHeight = right?.height ?? 0
        return abs(leftHeight - rightHeight) <= 1
    }
    
    var isleftChild: Bool {
        return parent != nil && parent!.left == self
    }
    var isRightChild: Bool {
        return parent != nil && parent!.right == self
    }
    
    /// 更新节点高度(其实就是重新计算一遍)
    /// 因为add node之后，只会影响其父节点以及以上节点 且并不一定高度会增加
    func updateHeight() {
        //22222第一次写成这样了：node.height += 1  千万别这样写。height高度并不是一定会增加 动手画一下就明白了
        let leftHeight = left?.height ?? 0
        let rightHeight = right?.height ?? 0
        height = max(leftHeight, rightHeight) + 1
    }
    
    var tallerChild: Node<Element>? {
        let leftHeight = left?.height ?? 0
        let rightHeight = right?.height ?? 0
        if leftHeight > rightHeight {
            return left
        }else if leftHeight < rightHeight {
            return right
        }else {
            return isleftChild ? left : right
        }
    }

}
