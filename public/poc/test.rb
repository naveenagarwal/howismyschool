array = [
  [11,1,13],
  [14,11,7],
  [5,14,9],
  [6,7,4]
]

class Node
  attr_accessor :val, :left, :right

  def initialize(val, left = nil, right = nil)
   @val = val
   @left = left
   @right = right
  end

end

root = Node.new array[0][1]
left_node = Node.new array[0][0]
right_node = Node.new array[0][2]
root.left = left_node
root.right = right_node

right_nodes = [root.right]

array[1..-1].each do |a|
  if(left_node.val == a[1])
    left_node.left = Node.new a[0]
    right_nodes << (left_node.right = Node.new a[2])
    left_node = left_node.left
  else
    right_nodes.each do |rn|
      if rn.val == a[1]
        rn.left = Node.new a[0]
        rn.right = Node.new a[2]
      end
    end
  end
end

def preorder(n)
  return if n.nil?

  puts n.val
  preorder n.left
  preorder n.right
end

preorder root
