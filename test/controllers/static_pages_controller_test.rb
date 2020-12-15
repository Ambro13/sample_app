#класс-тест созданного контроллера статических страниц
require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    static_pages_home_path
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorial Sample App" #Этот код проверяет наличие тэга <title>, содержащего строку “Home | Ruby on Rails Tutorial Sample App”.
  end

  test "should get help" do
    get static_pages_help_path
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App" #Этот код проверяет наличие тэга <title>, содержащего строку “Home | Ruby on Rails Tutorial Sample App”.
  end
  
   test "should get about" do
    get static_pages_about_path
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App" #Этот код проверяет наличие тэга <title>, содержащего строку “Home | Ruby on Rails Tutorial Sample App”.
  end
  
    test "should get contact" do
    get static_pages_contact_path
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end
  
end
