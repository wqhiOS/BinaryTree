//
//  RedBlackTree.swift
//  BinaryTree
//
//  Created by 吴启晗 on 2019/11/22.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import Cocoa

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
        return (color == .black ? "#" : "") + "\(element)"
      
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
