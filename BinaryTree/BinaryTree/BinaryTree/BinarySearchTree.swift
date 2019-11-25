//
//  BinarySearchTree.swift
//  BinaryTree
//
//  Created by wuqh on 2019/11/21.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import Foundation

/// 二叉搜索树
class BinarySearchTree<Element: Comparable> {
   
    var root: Node<Element>?
    var isEmpty: Bool {return size == 0}
    
    private var size: Int = 0
    
    func add(_ element: Element) {
        
        if root == nil {
            let node = createElement(element, parent: nil)
            root = node
            size += 1
            afterAdding(node)
            return
        }
    
        var parentNode = root
        var targetNode = root
        var compareResult: ComparisonResult = .orderedSame
        while parentNode != nil {
            targetNode = parentNode
            compareResult = compare(element,parentNode!.element)
            switch compareResult {
            case .orderedAscending:
                parentNode = parentNode!.left
                break
            case .orderedDescending:
                parentNode = parentNode!.right
                break
            case .orderedSame:
                parentNode = nil
                break
            }
        }
        
        switch compareResult {
        case .orderedAscending:
            let node = createElement(element, parent: targetNode)
            targetNode?.left = node
            size += 1
            afterAdding(node)
        case .orderedDescending:
            let node = createElement(element, parent: targetNode)
            targetNode?.right = node
            size += 1
            afterAdding(node)
        case .orderedSame:
            targetNode?.element = element
            afterAdding(targetNode!)
        }
        
    }
    
    func afterAdding(_ node: Node<Element>) {}

    func remove(_ element: Element) {
        guard var node = node(withElement: element) else {
            return
        }
        
        // 如果删除节点度为2，那么最后还是相当于删除度为1或者0的节点。
        // 所以先判断这个
        if node.hasTowChildren {
            
            guard let successor = successor(node: node) else {
                return
            }
            node.element = successor.element
            node = successor
            
        }
        //走到这里，说明 node度要么是0 要么是1
        let replacement = node.left ?? node.right
        if replacement != nil {//node度为1
            
            if let parent = node.parent {
                if parent.left == node {
                    parent.left = replacement
                }else {
                    parent.right = replacement
                }
                replacement?.parent = parent
            }else {
                root = replacement
                replacement?.parent = nil
            }
            afterRemoving(node, replacement: replacement!)
        }else {//度为0

            if node == node.parent?.left {
                node.parent?.left = nil
            }else {
                node.parent?.right = nil
            }
            
            if node == root {
                root = nil
            }
            
            afterRemoving(node, replacement: nil)
        }
        
        size -= 1
        
    }
    
    func afterRemoving(_ node: Node<Element>, replacement: Node<Element>?) {}
    
    func clear() {
        root = nil
        size = 0
    }
    
    func contains(_ element: Element) -> Bool{
        if node(withElement: element) != nil {
            return true
        }else {
            return false
        }
    }
    
    func createElement(_ element: Element,parent: Node<Element>?) -> Node<Element> {
        return Node(element: element, parent: parent)
    }
    
    
    /// 是否是完全二叉树
    func isCompleted() {
        
    }
    
}

// MARK: - Traversal
extension BinarySearchTree {
    func preorderTraversal(_ block: (Element)->Void) {
        preorderTraversal(root, block: block)
    }
    
    private func preorderTraversal(_ node: Node<Element>?,block: (Element)->Void) {
        guard let _node = node else {
            return
        }
        block(_node.element)
        preorderTraversal(_node.left, block: block)
        preorderTraversal(_node.right, block: block)
    }
    
    
    func inorderTraversal(_ block: (Element)->Void)  {
        inorderTraversal(root, block: block)
    }
    
    private func inorderTraversal(_ node: Node<Element>?, block: (Element)->Void) {
        guard let _node = node else {
            return
        }
        inorderTraversal(_node.left, block: block)
        block(_node.element)
        inorderTraversal(_node.right,block: block)
    }
    
    func postorderTraversal(_ block: (Element)->Void) {
        postorderTraversal(root, block: block)
    }
    
    private func postorderTraversal(_ node: Node<Element>?, block: (Element)->Void) {
        guard let _node = node else {
            return
        }
        postorderTraversal(_node.left, block: block)
        postorderTraversal(_node.right,block: block)
        block(_node.element)
    }
    
    func levelTraversal(_ block: (Element)->Void) {
        guard let root = root else {
            return
        }
        var queue = [Node<Element>]()
        queue.append(root)
        while !queue.isEmpty {
            let node = queue.removeFirst()
            block(node.element)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
    
}

extension BinarySearchTree {
    
    private func node(withElement element: Element) -> Node<Element>?{
        var node = root
        while node != nil {
            let result = compare(element, node!.element)
            switch result {
            case .orderedAscending:
                node = node!.left
            case .orderedDescending:
                node = node!.right
            case .orderedSame:
                return node
            }
        }
        return nil
    }
    
    /// 前序节点
    /// - Parameter node: node
    private func predecessor(node: Node<Element>) -> Node<Element>?{
        
        if node.left != nil {
            var predecessor = node.left
            while predecessor?.right != nil {
                predecessor = predecessor?.right
            }
            return predecessor
        }
    
        var targetNode = node
        while targetNode.parent != nil && targetNode.parent!.left != nil && targetNode.parent!.left! == targetNode {
            targetNode = targetNode.parent!
        }
        return targetNode.parent
        
    }
    
    /// 后继节点
    /// - Parameter node: 后继节点
    private func successor(node: Node<Element>) -> Node<Element>? {
        if node.right != nil {
                var successor = node.right
                while successor?.left != nil {
                    successor = successor?.left
                }
                return successor
            }
        
        var targetNode = node
        while targetNode.parent != nil && targetNode.parent!.right != nil && targetNode.parent!.right! == targetNode {
            targetNode = targetNode.parent!
        }
        return targetNode.parent
    }

    private func compare(_ e1: Element,_ e2: Element) -> ComparisonResult{
        
        if e1 < e2 {
            return .orderedAscending
        }else if e1 > e2 {
            return .orderedDescending
        }else {
            return .orderedSame
        }
        
    }
    
}

class Node<Element:Comparable>: CustomDebugStringConvertible {

    var left: Node<Element>?
    var right: Node<Element>?
    /// 注意：这里必须使用弱指针，否则调用clear的时候，root置位nil，其他节点不会销毁
    weak var parent: Node<Element>?
    var height: Int = 1
    var element: Element
    
    var isLeaf: Bool {
        return (left == nil && right == nil)
    }
    
    var hasTowChildren: Bool {
        return (left != nil && right != nil)
    }
    
    init(element: Element,parent: Node<Element>?) {
        self.element = element
        self.parent = parent
    }
    
    deinit {
       
    }
    
    var debugDescription: String {
        if let parentElement = parent?.element {
            return "\(element)(\(parentElement))"
        }else {
            return "\(element)"
        }
    }
    
}

extension Node: Equatable {
    static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
        return Unmanaged.passRetained(lhs).toOpaque() == Unmanaged.passRetained(rhs).toOpaque()
//        return lhs.element == rhs.element
    }
}



