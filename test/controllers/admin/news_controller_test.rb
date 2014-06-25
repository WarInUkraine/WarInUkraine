require 'test_helper'

class Admin::NewsControllerTest < ActionController::TestCase
  setup do
    @news = admin_news(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_news)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_news" do
    assert_difference('Admin::News.count') do
      post :create, admin_news: { description: @news.description, happened_at: @news.happened_at, status: @news.status, text: @news.text, title: @news.title, user_id: @news.user_id, youtube_data: @news.youtube_data, youtube_url: @news.youtube_url }
    end

    assert_redirected_to admin_news_path(assigns(:admin_news))
  end

  test "should show admin_news" do
    get :show, id: @news
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @news
    assert_response :success
  end

  test "should update admin_news" do
    patch :update, id: @news, admin_news: { description: @news.description, happened_at: @news.happened_at, status: @news.status, text: @news.text, title: @news.title, user_id: @news.user_id, youtube_data: @news.youtube_data, youtube_url: @news.youtube_url }
    assert_redirected_to admin_news_path(assigns(:admin_news))
  end

  test "should destroy admin_news" do
    assert_difference('Admin::News.count', -1) do
      delete :destroy, id: @news
    end

    assert_redirected_to admin_news_index_path
  end
end
