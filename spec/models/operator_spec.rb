require 'rails_helper'

RSpec.describe Operator do
  describe '#valid?' do
    subject { operator.valid? }

    let(:operator) do
      described_class.new(
        username:,
        password:,
        password_confirmation:,
        email:
      )
    end
    let(:username) { 'test_user' }
    let(:password) { 'valid_password' }
    let(:password_confirmation) { 'valid_password' }
    let(:email) { 'test_email@example.com' }

    context '登録の場合' do
      context 'username' do
        context '名前が空の場合' do
          let(:username) { nil }

          it { is_expected.to be false }
        end

        context '名前が空文字の場合' do
          let(:username) { '' }

          it { is_expected.to be false }
        end

        context '名前が65文字の場合' do
          let(:username) { 'a' * 65 }

          it { is_expected.to be false }
        end

        context '名前が64文字の場合' do
          let(:username) { 'a' * 64 }

          it { is_expected.to be true }
        end
      end

      context 'password' do
        context 'パスワードが空の場合' do
          let(:password) { nil }
          let(:password_confirmation) { nil }

          it { is_expected.to be false }
        end

        context 'パスワードが空文字の場合' do
          let(:password) { '' }
          let(:password_confirmation) { '' }

          it { is_expected.to be false }
        end

        context 'パスワードが7文字の場合' do
          let(:password) { 'a' * 7 }
          let(:password_confirmation) { 'a' * 7 }

          it { is_expected.to be false }
        end

        context 'パスワードが8文字の場合' do
          let(:password) { 'a' * 8 }
          let(:password_confirmation) { 'a' * 8 }

          it { is_expected.to be true }
        end

        context 'パスワードが64文字の場合' do
          let(:password) { 'a' * 64 }
          let(:password_confirmation) { 'a' * 64 }

          it { is_expected.to be true }
        end

        context 'パスワードが65文字の場合' do
          let(:password) { 'a' * 65 }
          let(:password_confirmation) { 'a' * 65 }

          it { is_expected.to be false }
        end

        context 'パスワードに許可されない文字が含まれる場合' do
          let(:password) { 'hogehoge{' }
          let(:password_confirmation) { 'hogehoge{' }

          it { is_expected.to be false }
        end

        context 'パスワード確認がパスワードと一致しない場合' do
          let(:password) { 'valid_password' }
          let(:password_confirmation) { 'difference_password' }

          it { is_expected.to be false }
        end
      end

      context 'email' do
        context 'メールアドレスが空の場合' do
          let(:email) { '' }

          it { is_expected.to be false }
        end

        context 'メールアドレスのフォーマットが不正の場合' do
          let(:email) { 'invalid_format' }

          it { is_expected.to be false }
        end
      end
    end

    context '更新の場合' do
      let(:operator) { create(:operator) }

      context '変更がない場合' do
        it { is_expected.to be true }
      end

      context '変更がある場合' do
        context 'username' do
          before { operator.username = username }

          context '名前が空の場合' do
            let(:username) { nil }

            it { is_expected.to be false }
          end

          context '名前が空文字の場合' do
            let(:username) { '' }

            it { is_expected.to be false }
          end

          context '名前が65文字の場合' do
            let(:username) { 'a' * 65 }

            it { is_expected.to be false }
          end

          context '名前が64文字の場合' do
            let(:username) { 'a' * 64 }

            it { is_expected.to be true }
          end
        end

        context 'password' do
          before do
            operator.password = password
            operator.password_confirmation = password_confirmation
          end

          context 'パスワードが空の場合' do
            let(:password) { nil }
            let(:password_confirmation) { nil }

            it { is_expected.to be false }
          end

          context 'パスワードが空文字の場合' do
            let(:password) { '' }
            let(:password_confirmation) { '' }

            it { is_expected.to be false }
          end

          context 'パスワードが7文字の場合' do
            let(:password) { 'a' * 7 }
            let(:password_confirmation) { 'a' * 7 }

            it { is_expected.to be false }
          end

          context 'パスワードが8文字の場合' do
            let(:password) { 'a' * 8 }
            let(:password_confirmation) { 'a' * 8 }

            it { is_expected.to be true }
          end

          context 'パスワードが64文字の場合' do
            let(:password) { 'a' * 64 }
            let(:password_confirmation) { 'a' * 64 }

            it { is_expected.to be true }
          end

          context 'パスワードが65文字の場合' do
            let(:password) { 'a' * 65 }
            let(:password_confirmation) { 'a' * 65 }

            it { is_expected.to be false }
          end

          context 'パスワードに許可されない文字が含まれる場合' do
            let(:password) { 'hogehoge{' }
            let(:password_confirmation) { 'hogehoge{' }

            it { is_expected.to be false }
          end

          context 'パスワード確認がパスワードと一致しない場合' do
            let(:password) { 'valid_password' }
            let(:password_confirmation) { 'difference_password' }

            it { is_expected.to be false }
          end
        end

        context 'email' do
          before { operator.email = email }

          context 'メールアドレスが空の場合' do
            let(:email) { '' }

            it { is_expected.to be false }
          end

          context 'メールアドレスのフォーマットが不正の場合' do
            let(:email) { 'invalid_format' }

            it { is_expected.to be false }
          end
        end
      end
    end
  end
end
