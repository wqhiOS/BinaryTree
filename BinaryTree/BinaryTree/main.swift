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
    print("Start")
    
    elements.forEach { (element) in
        print("#####\(element)#####")
        rbTree.remove(element)
        debugPrint(rbTree)
    }
    
    
}

//test0()
//test1()
//test2()
//test3()
//AVLTreeAddTest()
RedBlackTreeAddTest()






