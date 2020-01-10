//
//  main.swift
//  BinaryTree
//
//  Created by wuqh on 2019/11/21.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import Foundation


/**
()括号中的内容 代表父节点
           ┌──────7──────┐
           │             │
       ┌─4(7)─┐       ┌─9(7)─┐
       │      │       │      │
   ┌─2(4)─┐  5(4)─┐ 8(9) ┌─11(9)─┐
   │      │       │      │       │
 1(2)    3(2)    6(5) 10(11)   12(11)
 */
let elements = [7,4,9,2,5,8,11,1,3,6,10,12]

func test0() {
    let tree = BinarySearchTree<Int>()

    elements.forEach { (element) in
        tree.add(element)
    }
    
    debugPrint(tree)
    tree.clear()
    debugPrint(tree)
}

/**
 二叉搜索树-添加、删除测试
 */
func test1() {
    let tree = BinarySearchTree<Int>()

    elements.forEach { (element) in
        tree.add(element)
    }
    debugPrint(tree)
    elements.forEach { (element) in
        print("===== \(element) =====")
        tree.remove(element)
    debugPrint(tree)
    }
}

/**
 二叉树遍历测试
 */
func test2() {
    let elements = [7,4,9,2,5,8,11,1,3,6,10,12]

    let tree = BinarySearchTree<Int>()
    elements.forEach { (element) in
        tree.add(element)
    }
    print(tree)
    
    print("preorderTraversal")
    tree.preorderTraversal { (element) in
        print(element, separator: "", terminator: " ")
    }
    print("\n")
    
    print("inorderTraversal")
    tree.inorderTraversal { (element) in
        print(element, separator: "\n", terminator: " ")
    }
    print("\n")
    
    print("postorderTraversal")
    tree.postorderTraversal { (element) in
        print(element, separator: "\n", terminator: " ")
    }
    print("\n")
    
    print("levelTraversal")
    tree.levelTraversal { (element) in
        print(element, separator: "\n", terminator: " ")
    }
    print("\n")
}

func test3() {
    let tree = BinarySearchTree<Int>()
    elements.forEach { (element) in
        tree.add(element)
    }
    debugPrint(tree)
}

func AVLTreeAddTest() {
    let elements = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]
    let avltree = AVLTree<Int>()
    elements.forEach { (element) in
        print("#####\(element)#####")
        avltree.add(element)
        debugPrint(avltree)
    }
    
}

func RedBlackTreeAddTest() {
    let elements = [4, 75, 82, 85, 36, 20, 21, 84, 55, 51, 11, 25, 32, 15, 57, 3]
    let rbTree = RedBlackTree<Int>()
    elements.forEach { (element) in
        rbTree.add(element)
    }
    debugPrint(rbTree)

    elements.forEach { (element) in
        print("willRemove 【\(element)】")
        rbTree.remove(element)
        debugPrint(rbTree)
    }
}

//非递归 使用迭代 前、中、后序遍历测试
func traversalTest() {
    let tree = BinarySearchTree<Int>()
    elements.forEach { (element) in
        tree.add(element)
    }
    debugPrint(tree)
    print("==========前序遍历：")
    var list = [Int]()
    tree.preorderTraversal2 { (element) in
        list.append(element)
    }
    print(list)
    list.removeAll()
    
    print("==========中序遍历：")
    tree.inorderTraversal2 { (element) in
        list.append(element)
    }
    print(list)
    list.removeAll()
    
    print("==========后序遍历：")
    tree.postorderTraversal2 { (element) in
        list.append(element)
    }
    print(list)
    list.removeAll()
    
    tree.postorderTraversal { (element) in
        list.append(element)
    }
    print(list)
    
//    tree.postorderTraversal2()
    
}

//test0()
//test1()
//test2()
//test3()
//AVLTreeAddTest()
//RedBlackTreeAddTest()
traversalTest()


// MARK: - leetcode
public class TreeNode {
     public var val: Int
     public var left: TreeNode?
     public var right: TreeNode?
     public init(_ val: Int) {
         self.val = val
         self.left = nil
         self.right = nil
     }
}
class Solution {
    //701
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        var root = root
        if root == nil {
            root = TreeNode(val)
            return root
        }
        var node = root,parentNode = root
        var compare = 0
        while node != nil {
            parentNode = node
            if val < node!.val {
                node = node!.left
                compare = -1
            }else if val > node!.val {
                node = node?.right
                compare = 1
            }else {
                compare = 0
                break
            }
        }
        if compare < 0 {
            parentNode?.left = TreeNode(val)
        }else if compare > 0{
            parentNode?.right = TreeNode(val)
        }
        
        return root
    }
    //450
    func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
        
        guard let _root = root else {
            return root
        }
        //查找key对应的node
        var keyNode: TreeNode?
        var queue = [TreeNode]()
        queue.append(_root)
        while let node = queue.first {
            if node.val == key {
                keyNode = node
                break
            }else {
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        guard let _keyNode = keyNode else{
            return root
        }
        
        //_keyNode 找到了
        var willRemoveNode: TreeNode?
        let left = _keyNode.left
        let right = _keyNode.right
        if left != nil && right != nil {//度为2
            //查找前驱结点
            var preNode = left!
            while preNode.right != nil {
                preNode = preNode.right
            }
        }
        
        if left == nil && right == nil {//度为0
            
        }else {//度为1
            
        }
        
        return nil
    }
    
    func node(val: Int, root: TreeNode) {
       
    }
}








