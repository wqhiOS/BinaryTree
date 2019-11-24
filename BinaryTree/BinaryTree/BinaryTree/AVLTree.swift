//
//  AVLTree.swift
//  二叉树
//
//  Created by wuqh on 2019/11/21.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import Foundation

/// 平衡二叉树(我们常说的平衡二叉树一般指的都是AVL树)
class AVLTree<Element: Comparable>: BinaryBalanceTree<Element> {
    
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
                break //不平衡是因为 平衡因子=2，那说明之前平衡因子肯定是1， 所以恢复平衡后，平衡因子就会变为1，就变回了添加之前，所以它往上的父节点都可以不再处理了 所以break掉。
            }
            parent = parent!.parent
        }
    }
    /*
     添加会导致所有祖先节点都失衡，只要让高度最低的失衡节点恢复平衡，他往上的祖先借点的高度也就减了1，也就从失衡时的平衡因子2变为了1，所以只需要处理一次。
     删除和添加正好相反。比添加更难理解
     删除导致其父节点或者祖先节点失衡，那该失衡节点往上肯定不会再有节点失衡了。因为失衡是删除导致的，这个删除的节点肯定是在失衡节点的左右子树中，那颗高度最小的子树中删除，这样才会导致失衡。所以在左右子树中，找其中一颗高度相对较小的一课树删除一个节点不会影响这个数的高度。所以高度没有变，所以该失衡节点往上的节点就肯定不会失衡。
     失衡时 平衡因子肯定为2.也就是说如果是右子树高度比较高，那么假设左子树高度为n，右子树高度必定为n+2.失衡的这个节点的子树高度也为n+2.并且失衡之前也是n+2.所以不影响失衡节点往上的节点的平衡因子。
     因为要恢复平衡，所以失衡的这个节点的子树，恢复高度后，整棵树的高度必定减小。所以一旦减小，就影响了他的父节点已经所有祖先节点的s平衡因子。所以不能break
     */
    
    
    override func afterRemoving(_ node: Node<Element>) {
        var parent = node.parent
        while parent != nil {
            if parent!.isBalance {
                parent!.updateHeight()
            }else {
                restoreBalance(node: parent!)
                 //break
                 // 添加和删除之后的修复，唯一的区别就是这里没有break。
                //为什么呢？
                /**
                 因为remove之后如果失衡，然后恢复平衡，就代表
                 */
            }
            parent = parent!.parent
        }
    }
    
     func restoreBalance(node grand: Node<Element>) {
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
