require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "Properties" do
    before(:all) { @user = User.new}

    describe "attributes" do
      [:email, :password, :task_lists].each do |attribute|
        it("should respond to #{attribute}") {
          expect(@user).to respond_to attribute
        }
      end
    end

    describe "methods" do
      [:create_task_list, :delete_task_list].each do |method|
        it("should respond to #{method}") {
          expect(@user).to respond_to method
        }
      end
    end
  end

  describe "Validations" do
    it("should be valid with an email and password") {
      user = User.new(email: 'someone@somewhere.com', password: 'password')
      expect(user).to be_valid
    }

    it("should not be valid with a password less than 6 chars") {
      user = User.new(email: 'someone@somewhere.com', password: 'passwor')
      expect(user).to_not be_valid
    }

    it("should not be valid with a malformed email") {
      user = User.new(email: 'someone', password: 'password')
      expect(user).to_not be_valid
    }

    it("should not be valid with a duplicate email") {
      user1 = User.create(email: 'someone@somewhere.com', password: 'password')
      expect(user1.id).to_not be nil

      user2 = User.create(email: 'someone@somewhere.com', password: 'password')
      expect(user2).to_not be_valid
    }

  end

end
