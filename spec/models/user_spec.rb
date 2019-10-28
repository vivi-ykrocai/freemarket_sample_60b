require 'rails_helper'
describe User do
  describe '#create' do

    #  nick_nameとemail、passwordとpassword_confirmationが存在すれば登録できること
    # it "is valid with a nickname, email, password, password_confirmation " do
    #   user = build(:user)
    #   expect(user).to be_valid
    # end

    #  nick_nameが空では登録できないこと
    it "is invalid without a nick_name" do
      user = build(:user, nick_name: "")
      user.valid?
      # binding.pry
      expect(user.errors[:nick_name]).to include("を入力してください")
    end
    
    it "nick_nameが重複していると登録できない" do
      user = create(:user)
      another_user = build(:user, nick_name: user.nick_name)
      another_user.valid?
      # binding.pry
      expect(another_user.errors[:nick_name]).to include("has already been taken")
    end

    #  emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください", "は不正な値です")
    end
    
    #  重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end  

    #  passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください", "は7文字以上で入力してください")
    end
    
    #  passwordが7文字以上であれば登録できること
    it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end
    
    #  passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password:"000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    #  passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    
    # family_name空だと保存されない
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください", "は不正な値です")
    end

    it "family_nameが漢字以外だと登録されない" do
      user = build(:user, family_name: "ginoza")
      user.valid?
      expect(user.errors[:family_name]).to include("は不正な値です")
    end
    
    # last_nameが空だと保存されない
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end

    # family_name_kanaが空だと保存されない
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end

    # family_name_kanaが全角カナだと保存される
    it "is saved if family_name_kana is kana" do
      user = build(:user, family_name_kana: "ギノザ")
      expect(user).to be_valid
    end

    # family_name_kanaが全角カナ以外だと保存されない
    it "is family_name_kanaが以外だと保存されない" do
      user = build(:user, family_name_kana: "宜野座")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は不正な値です")
    end

    it "last_name_kanaが半角ｶﾅだと保存されない" do
      user = build(:user, family_name_kana: "ｲﾇ")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は不正な値です")
    end

    # last_name_kanaが空だと保存されない
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("is invalid")
    end

    # last_name_kanaがカナだと保存される
    it "is saved if last_name_kana is kana" do
      user = build(:user, last_name_kana: "イヌ")
      expect(user).to be_valid
    end

    # last_name_kanaがカナ以外だと保存されない
    it "is last_name_kanaが以外だと保存されない" do
      user = build(:user, last_name_kana: "犬犬犬")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("is invalid")
    end

  # ＃last_name_kanaが半角のｶﾅだと保存されない
    it "last_name_kanaが半角ｶﾅだと保存されない" do
      user = build(:user, last_name_kana: "ｲﾇ")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("is invalid")
    end

    # birthdayが空だと保存されない
    it "is invalid without a birthday" do
      user = build(:user,  birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    #. postal_codeが空だと保存されない
    it "is invalid without a postal_code" do
      user = build(:user, postal_code: "")
      user.valid?
      expect(user.errors[:postal_code]).to include("can't be blank")
    end

    # postal_codeが7桁だと保存される
    it "is valid with a postal_code that has more than 7 characters" do
      user = build(:user, postal_code: "1234567")
      expect(user).to be_valid
    end

    # postal_codeが7桁以外だと保存されない
    it "is not saved if postal_code is other than 7 digits" do
      user = build(:user, postal_code: "12345678")
      user.valid?
      expect(user.errors[:postal_code]).to include("is the wrong length (should be 7 characters)")
    end

    # prefecturesが空だと保存されない
    it "is invalid without a prefectures" do
      user = build(:user, prefectures: "")
      user.valid?
      expect(user.errors[:prefectures]).to include("can't be blank")
    end

    # phone_numberが空だと保存されない
    it "is invalid without a phone_number" do
      user = build(:user, phone_number: "")
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    #phone_numberが11桁だと保存されること
    it "is saved when phone_number is 11 digits" do
      user = build(:user, phone_number: "00000000000")
      expect(user).to be_valid
    end

    # phone_numberが11桁以外だと保存されないこと
    it "is not saved if phone_number is other than 11 digits" do
      user= build(:user, phone_number: "000000")
      user.valid?
      expect(user.errors[:phone_number]).to include("is the wrong length (should be 11 characters)")
    end

    it "phone_numberが重複していると登録できない" do
      user = create(:user)
      another_user = build(:user, phone_number: user.phone_number)
      another_user.valid?
      expect(another_user.errors[:phone_number]).to include("has already been taken")
    end  

    # cityが空だと保存されない
    it "is invalid without a city" do
      user= build(:user, city:  "")
      user.valid?
      expect(user.errors[:city]).to include("can't be blank")
    end

    # addressが空だと保存されない
    it "is invalid without a address" do
      user= build(:user, address:  "")
      user.valid?
      expect(user.errors[:address]).to include("can't be blank")
    end
  end
end

