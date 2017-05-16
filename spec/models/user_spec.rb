require 'rails_helper'

RSpec.describe User, type: :model do
  
  before(:each) do
    @user = User.create!(
      first_name: 'Dwayne',
      last_name: 'Johnson',
      email: 'test@email.com',
      password: 'theRock',
      password_confirmation: 'theRock'
    )
  end

  describe 'Validations' do

    it 'fails if first name is blank' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'fails if last name is blank' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'fails if email is blank' do
      @user.email = nil
      @user.valid?  
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'fails if email is not unique regardless of letter case' do
      @user2 = User.create(email: 'TEST@EMAIL.COM')
      @user2.email = @user.email.downcase
      @user2.valid?
      expect(@user.errors.full_messages).not_to include([])
    end

    it 'must be same password in both fields' do
      @user = User.create(password: 'theRock', password_confirmation: 'theRock')
      expect(@user.password).to eq(@user.password_confirmation)
    end

    it 'must have a password longer than minimum(3) characters' do
      @user = User.create(first_name: 'pwTest', last_name: 'pwTest', email: 'pwTest', password: 'ab')
      @user.valid?
      expect(@user).not_to be_valid
    end
    
  end

  describe '.authenticate_with_credentials' do

    it 'logs user in if credentials are valid' do
      user = User.authenticate_with_credentials('test@email.com', 'theRock')
      expect(user).to eql(@user)
    end

    it 'passes regardless of letter case in email' do
      user = User.authenticate_with_credentials('TEST@EMAIL.COM', 'theRock')
    end

    it 'passes regardless of extra spaces' do
      user = User.authenticate_with_credentials(' test@email.com ', 'theRock')
    end

    it 'fails be an incorrect email' do
      user = User.authenticate_with_credentials('wrongTest@email.com', 'theRock')
      expect(user).to eq(nil)
    end

    it 'fails be an incorrect password' do
      user = User.authenticate_with_credentials('test@email.com', 'theStone')
      expect(user).to eq(nil)
    end


    
  end




end
