require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザ登録ができる時' do
      it 'password:半角英字と数字の混合であれば有効' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザ登録ができない時' do
      it 'nickname:必須' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'email:必須' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'email:一意性' do
        @user.save
        raise "Failed to save @user: #{@user.errors.full_messages.join(', ')}" unless @user.persisted?

        another_user = FactoryBot.build(:user, email: @user.email)
        # another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'email:「@」を含む' do
        @user.email = 'magicalmiraiemail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'password:必須' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'password:6文字以上' do
        @user.password = '11122'
        @user.password_confirmation = '11122'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'password:半角英字のみは無効' do
        @user.password = 'magical'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'password:半角数字のみは無効' do
        @user.password = '393939'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'password:全角文字を含むと登録できない' do
        @user.password = '３９３９３９'
        @user.password_confirmation = '３９３９３９'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には全角文字は使えません')
      end

      it 'passwordとpassword_confirmationが一致しない場合は無効' do
        @user.password = 'mag1calmirai'
        @user.password_confirmation = 'mag1cmira1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'full_width_lastname:必須' do
        @user.full_width_lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Full width lastname can't be blank")
      end

      it 'full_width_firstname:必須' do
        @user.full_width_firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Full width firstname can't be blank")
      end

      it 'full_width_lastnameが全角でなければ無効' do
        @user.full_width_lastname = 'Ononogi'
        @user.valid?
        expect(@user.errors.full_messages).to include('Full width lastname は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'full_width_firstnameが全角でなければ無効' do
        @user.full_width_firstname = 'Yotsugi'
        @user.valid?
        expect(@user.errors.full_messages).to include('Full width firstname は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'nickname:必須' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'katakana_lastname:必須' do
        @user.katakana_lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana lastname can't be blank")
      end

      it 'katakana_firstname:必須' do
        @user.katakana_firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana firstname can't be blank")
      end

      it 'katakana_lastnameがカタカナでなければ無効' do
        @user.katakana_lastname = 'おののぎ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Katakana lastname is invalid')
      end

      it 'katakana_firstnameがカタカナでなければ無効' do
        @user.katakana_firstname = 'よつぎ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Katakana firstname is invalid')
      end

      it '生年月日:必須' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
