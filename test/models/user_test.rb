require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",password: "foobar", password_confirmation: "foobar")
  end

  #ВАЛИДНОСТЬ
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  #ДЛИНА СТРОК
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  #Тесты для валидных форматов адресов электронной почты.
   test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  #Тесты валидации формата электронной почты
   test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  #тест на уникальность email`a
   test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  #ПАРОЛЬ
   test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  #удаление пользователя = удаление его постов
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  
  test "should follow and unfollow a user" do
    alena = users(:alena)
    archer  = users(:archer)
    assert_not alena.following?(archer)
    alena.follow(archer)
    assert alena.following?(archer)
    assert archer.followers.include?(alena)
    alena.unfollow(archer)
    assert_not alena.following?(archer)
  end
  
  test "feed should have the right posts" do
    alena = users(:alena)
    archer  = users(:archer)
    lana    = users(:lana)
    # Сообщения читаемого пользователя.
    lana.microposts.each do |post_following|
      assert alena.feed.include?(post_following)
    end
    # Собственные сообщения.
    alena.microposts.each do |post_self|
      assert alena.feed.include?(post_self)
    end
    # Сообщения нечитаемого пользователя.
    archer.microposts.each do |post_unfollowed|
      assert_not alena.feed.include?(post_unfollowed)
    end
  end
  
end
