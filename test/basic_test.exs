defmodule GroupMessageTest do
  use ExUnit.Case
  doctest GroupMessage

  test "can spawn a person node" do
    # need to a test where it spawns a new node that can spawn messages
  end

  test "person node can create a group node" do
    
  end

  test "other people can join a group node" do
    
  end

  test "group node can join a group node" do
    
  end

  test "can message pass between people nodes" do
    
  end

  test "can message pass between group nodes" do
    
  end

  test "can message pass between people and group nodes" do
    
  end

  test "person can leave group node" do
    
  end

  test "if last person leaves group node, group node will vanish" do
    
  end

  test "if node has no children, it will vanish" do
    
  end

  test "node cannot be children of parent" do
    # this is a more implicit test and should not be tested explicitly
  end
end
