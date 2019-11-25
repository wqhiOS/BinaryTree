# BinaryTree
使用Swift实现了BinarySearchTree、AVLTree、RedBlackTree。以及支持输出到控制台console中。

红黑树使用：

```swift

let elements = [4, 75, 82, 85, 36, 20, 21, 84, 55, 51, 11, 25, 32, 15, 57, 3]
let rbTree = RedBlackTree<Int>()
elements.forEach { (element) in
    rbTree.add(element)
}
debugPrint(rbTree)//打印

```

控制台输出：

```
                             36
                ____________/  \___________
              20                           75
          ___/  \__                  _____/  \_____
     [R]11         25              55              84
      / \         /  \            /  \            /  \
     4   15  [R]21    [R]32  [R]51    [R]57  [R]82    [R]85
    /
[R]3
```

[R] 代表红色节点，可自定义输出内容：

```swift
class RedBlackNode<Element: Comparable>: Node<Element> {
    
		....
    override var debugDescription: String {
        
        return (color == .black ? "" : "[R]") + "\(element)"
      
    }
}
```



