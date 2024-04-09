require 'rails_helper'

RSpec.describe SessionsController do
  include SessionsHelper

  describe '#new' do
    subject do
      get '/login'
    end

    let(:t_admin) { create(:t_admin) }

    it '200を返す ユーザー情報が保存されていない' do
      subject
      expect(response).to have_http_status(:ok)
      expect(session[:t_admin_id]).to be_nil
    end
  end

  describe '#create' do
    subject do
      post '/login', params: {
        session: {
          username:,
          password:
        }
      }
    end

    let(:t_admin) { create(:t_admin) }
    let(:username) { t_admin.username }
    let(:password) { t_admin.password }

    context 'usernameとpasswordの組み合わせが正しいとき' do
      it '302を返す ユーザー情報が保存される' do
        subject
        expect(response).to have_http_status(:found)
        expect(session[:t_admin_id]).to eq t_admin.id
      end

      it '/indexへリダイレクトする' do
        expect(subject).to redirect_to(index_path)
      end
    end
  end

  describe '#delete' do
    subject do
      delete '/logout'
    end

    let(:t_admin) { create(:t_admin) }
    let(:username) { t_admin.username }
    let(:password) { t_admin.password }

    before do
      post '/login', params: {
        session: {
          username:,
          password:
        }
      }
    end

    it '302を返す ユーザー情報が破棄される' do
      subject
      expect(response).to have_http_status(:found)
      expect(session[:t_admin_id]).to be_nil
    end

    it 'ログイン画面にリダイレクトする' do
      expect(subject).to redirect_to(login_path)
    end
  end
end
