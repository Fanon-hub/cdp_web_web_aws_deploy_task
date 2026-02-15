require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  include ActionDispatch::TestProcess::FixtureFile

  setup do
    @blog = blogs(:one)
  end

  test "should get index" do
    get blogs_url
    assert_response :success
  end

  test "should get new" do
    get new_blog_url
    assert_response :success
  end

  test "should create blog" do
    assert_difference('Blog.count') do
      post blogs_url, params: { blog: { content: @blog.content, title: @blog.title,
                                       thumbnail: fixture_file_upload('files/sample.png', 'image/png') } }
    end

    assert_redirected_to blog_url(Blog.last)
    assert Blog.last.thumbnail.attached?
  end

  test "should show blog" do
    get blog_url(@blog)
    assert_response :success
  end

  test "should get edit" do
    get edit_blog_url(@blog)
    assert_response :success
  end

  test "should update blog" do
    patch blog_url(@blog), params: { blog: { content: @blog.content, title: @blog.title,
                                             thumbnail: fixture_file_upload('files/sample.png', 'image/png') } }
    assert_redirected_to blog_url(@blog)
    @blog.reload
    assert @blog.thumbnail.attached?
  end

  test "should destroy blog" do
    assert_difference('Blog.count', -1) do
      delete blog_url(@blog)
    end

    assert_redirected_to blogs_url
  end
end
