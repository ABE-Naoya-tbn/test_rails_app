require 'rails_helper'

RSpec.describe TodoListItem do
  describe '#valid?' do
    subject { todo_list_item.valid? }

    let(:todo_list_item) do
      described_class.new(
        content:,
        status:
      )
    end
    let(:content) { '今日やること' }
    let(:status) { true }

    context '登録の場合' do
      context 'content' do
        context 'テキストが空の場合' do
          let(:content) { nil }

          it { is_expected.to be false }
        end

        context 'テキストが空文字の場合' do
          let(:content) { '' }

          it { is_expected.to be false }
        end

        context 'テキストが256文字の場合' do
          let(:content) { 'a' * 256 }

          it { is_expected.to be false }
        end

        context 'テキストが255文字の場合' do
          let(:content) { 'a' * 255 }

          it { is_expected.to be true }
        end
      end
    end

    context '更新の場合' do
      let(:todo_list_item) { create(:todo_list_item) }

      context '変更がない場合' do
        it { is_expected.to be true }
      end

      context '変更がある場合' do
        context 'content' do
          before { todo_list_item.content = content }

          context 'テキストが空の場合' do
            let(:content) { nil }

            it { is_expected.to be false }
          end

          context 'テキストが空文字の場合' do
            let(:content) { '' }

            it { is_expected.to be false }
          end

          context 'テキストが256文字の場合' do
            let(:content) { 'a' * 256 }

            it { is_expected.to be false }
          end

          context 'テキストが255文字の場合' do
            let(:content) { 'a' * 255 }

            it { is_expected.to be true }
          end
        end
      end
    end
  end
end
