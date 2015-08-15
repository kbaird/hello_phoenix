defmodule HelloPhoenix.HelloControllerTest do
  use HelloPhoenix.ConnCase

  test "GET /hello" do
    conn = get conn(), "/hello"
    assert html_response(conn, 200) =~ "Hello World, from Phoenix!"
  end
  test "GET /hello/zoidberg" do
    conn = get conn(), "/hello/zoidberg"
    assert html_response(conn, 200) =~ "Hello World, from zoidberg!"
  end

  @tag :hog # this would be a good way to partition resource-intensive tests that
            # need to be run, but not necessarily by default for every suite
  test "GET /hello/some_memory_intensive_operation" do
    conn = get conn(), "/hello/some_memory_intensive_operation"
    assert html_response(conn, 200) =~ "Hello World, from some_memory_intensive_operation!"
  end
end
