require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  
  #создание должно потребовать входа в систему пользователя
   test "create should require logged-in user" do
    assert_no_difference 'Relationship.count' do
      post :create
    end
    assert_redirected_to login_url
  end

  #уничтожение должно потребовать входа в систему пользователя
  test "destroy should require logged-in user" do
    assert_no_difference 'Relationship.count' do
      delete :destroy, id: relationships(:one)
    end
    assert_redirected_to login_url
  end
  
end
