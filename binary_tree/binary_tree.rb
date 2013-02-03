# Each node in a tree contains:
#   value => value that a particular node is storing
#   left  => A reference to the left child node
#   right => A reference to the right child node
class Node
  attr_accessor :value, :left, :right, :parent
end

# root => Parent of all other nodes in tree
class Tree
 attr_accessor :root
end
