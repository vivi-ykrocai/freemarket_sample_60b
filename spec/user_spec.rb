require 'rails_helper'
describe User do
  describe '#create' do
    it "nick_nameを確認" do
      user = User.new(nickname: "", email: "kkk3@gmail.com", password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
  end
end
