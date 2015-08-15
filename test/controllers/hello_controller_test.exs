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
end
