//
//  RedBlackTree.swift
//  BinaryTree
//
//  Created by 吴启晗 on 2019/11/22.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import Cocoa

/**
添加和删除后的平衡两个方法中都有部分重复代码，可以优化
 但是平衡逻辑太过复杂，代码优化后可能导致思路不清晰，看不懂。
 所以暂不优化。
*/
class RedBlackTree<Element: Comparable>: BinaryBalanceTree<Element> {

    override func afterAdding(_ node: Node<Element>) {
        //默认添加的节点为红色。这样更方便一点
        
        //1. 如果是根节点。根节点设置为黑色
        if node.parent == nil {// 
            color(node: node, color: .black)
            return
        }
        //2. 如果父节点是黑色，不需要做任何处理
        if nodeIsBlack(node: node.parent) {return}
        //3. 到这里，说明父节点是红色
        // 父节点是红色，分两大类，一类是叔节点为红色，另一类没有叔节点，或叔节点为黑色
        let uncle = node.uncle
        let parent = node.parent!
        let grand = node.parent!.parent!
        
        if nodeIsRed(node: uncle) {
            
            color(node: parent, color: .black)
            color(node: uncle!, color: .black)
            
            color(node: grand, color: .red)
            afterAdding(grand)
            return
            
        }else {
            if parent.isleftChild {
                if node.isleftChild {
                    rotateRight(node: grand)
                    
                    color(node: parent, color: .black)
                    color(node: grand, color: .red)
                }else {
                    rotateLeft(node: parent)
                    rotateRight(node: grand)
                    
                    color(node: node, color: .black)
                    color(node: grand, color: .red)
                }
            }else {
                if node.isRightChild {
                    rotateLeft(node: grand)
                    
                    color(node: parent, color: .black)
                    color(node: grand, color: .red)
                }else {
                    rotateRight(node: parent)
                    rotateLeft(node: grand)
                    
                    color(node: node, color: .black)
                    color(node: grand, color: .red)
                }
            }
        }
        
    }
    
    
    override func afterRemoving(_ node: Node<Element>, replacement: Node<Element>?) {
        //删除最后的操作，删除的都是度为0或1的节点。所以能来到这里的node，度只能为1或0，不可能为2
        
        if nodeIsRed(node: node) {//删除的是红色节点，直接忽略
            return
        }
        
        // 拥有一个red子节点的black节点: 将替代的子节点染成black即可
        if nodeIsRed(node: replacement) {
            color(node: replacement!, color: .black)
            return
        }
        
        if node.parent == nil {// 黑色节点，为root
            color(node: node, color: .black)
            return
        }
        
        
        
        /*
         注意这里如何判断是left还是right?
         因为这里已经删除了，所以可以拿到parent。但是根据parent拿不到已删除的node这个节点，
         所以无法用isLeftChild判断。
         又因为能到这里，说明node是黑色，如果node是黑色，它肯定有兄弟节点。所以只需要看parent的left right指针，哪个是空即可
         */
        
        // 这里 node.parent.left == nil。因为一旦被删除 left就是为空了，所以用left判断
//        let isLeft = (node.parent?.left == nil)
        // 这里不能只写 (node.parent?.left == nil) ，因为有一种情况 还没有删除。就是在该方法里面调用afterRmoveing的时候，
        let isLeft = node.parent?.left == nil || node.isleftChild
        
        // 走到这里肯定有parent
        let parent = node.parent!
        // 有parent，自己是黑色，那肯定有brother，根据性质5
        let brother = isLeft ? parent.right : parent.left
        
        if nodeIsBlack(node: brother) {//brother是黑色
            // brother 没有红色节点
            if !(nodeIsRed(node: brother?.left) || nodeIsRed(node: brother?.right)) {
                
                if nodeIsBlack(node: parent) {
                    color(node: brother!, color: .red)
                    afterRemoving(parent, replacement: nil)
                    return
                }else {
                    color(node: parent, color: .black)
                    color(node: brother!, color: .red)
                    return
                }
                
            }else {
            // brother 有红色节点
                if isLeft {
                    
                    //R
                    let brotherLeft = brother?.left
                    let brotherRight = brother?.right
                    if brotherLeft != nil && brotherRight != nil {//兄弟节点 有两个red
                        rotateLeft(node: parent)
                        color(node: brother!, color: color(node: parent))
                        color(node: brotherRight!, color: .black)
                        color(node: parent, color: .black)
                    }else if brotherLeft != nil {//brother有一个leftRed
                        
                        rotateRight(node: brother!)
                        rotateLeft(node: parent)
                        
                        color(node: brotherLeft!, color: color(node: parent))
                        color(node: brother!, color: .black)
                        color(node: parent, color: .black)
                        
                    }else {//brother有一个rightRed
                        
                        rotateLeft(node: parent)
                        color(node: brother!, color: color(node: parent))
                        color(node: brotherRight!, color: .black)
                        color(node: parent, color: .black)
                        
                    }
                }else {
                    //L
                    let brotherLeft = brother?.left
                    let brotherRight = brother?.right
                    if brotherLeft != nil && brotherRight != nil {//兄弟节点 有两个red
                        rotateRight(node: parent)
                        color(node: brother!, color: color(node: parent))
                        color(node: brotherLeft!, color: .black)
                        color(node: parent, color: .black)
                    }else if brotherLeft != nil {//brother有一个leftRed
                        rotateRight(node: parent)
                        color(node: brother!, color: color(node: parent))
                        color(node: brotherLeft!, color: .black)
                        color(node: parent, color: .black)
                    }else {//brother有一个rightRed
                        
                        rotateLeft(node: brother!)
                        rotateRight(node: parent)
                        color(node: brotherLeft!, color: color(node: parent))
                        color(node: brother!, color: .black)
                        color(node: parent, color: .black)
                        
                    }
                }
            }
        }else {//broter是红色
            
            color(node: brother!, color: .black)
            color(node: parent, color: .red)
            if isLeft {
                rotateLeft(node: parent)
            }else {
                rotateRight(node: parent)
            }
            afterRemoving(node, replacement: nil)
            
        }
        
    }
    
    override func createElement(_ element: Element,parent: Node<Element>?) -> Node<Element> {
        return RedBlackNode(element: element, parent: parent)
    }
    
}

extension RedBlackTree {
    private func color(node: Node<Element>) -> RedBlackNode<Element>.Color {
        return (node as? RedBlackNode)?.color ?? .red
    }
    private func color(node: Node<Element>, color: RedBlackNode<Element>.Color) {
        (node as? RedBlackNode)?.color = color
    }
    private func nodeIsRed(node: Node<Element>?) -> Bool {
        return (node as? RedBlackNode)?.color == .red
    }
    private func nodeIsBlack(node: Node<Element>?) -> Bool {
        return (node as? RedBlackNode)?.color == .black
    }
}


class RedBlackNode<Element: Comparable>: Node<Element> {
    
    enum Color: Int {
        case red = 0
        case black = 1
    }
    
    var color: RedBlackNode.Color = .red
    override var debugDescription: String {
        
        return (color == .black ? "" : "[R]") + "\(element)"
      
    }
}
extension Node {
    var uncle: RedBlackNode<Element>? {
        if parent?.isleftChild ?? false {
            return parent?.parent?.right as? RedBlackNode<Element>
        }
        if parent?.isRightChild ?? false {
            return parent?.parent?.left as? RedBlackNode<Element>
        }
        return nil
    }
}
