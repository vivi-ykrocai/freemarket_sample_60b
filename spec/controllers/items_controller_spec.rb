require 'rails_helper'

describe ItemsController do

  describe 'GET index' do
    let(:user) { create(:user) }
    let(:categorie) {create(:categorie) }

    context 'index assigns ' do
      # itemsに正しく変数がはいる
      it 'assigns @items' do
        items = create_list(:item, 5)
        get :index
        expect(assigns(:items)).to match(items.sort{|a, b| b.created_at <=> a.created_at })
      end
    end
    context 'index renders ' do
      # 正しくページ遷移が行われる
      it 'redners index' do
        items = create_list(:item,5)
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    let(:categorie) {create(:categorie) }
    context 'can delete' do
      # ログイン中ユーザー＝出品者ユーザーの場合、アイテムを削除できる
      it '@item.seller_id == current_user.id' do
        login user
        item = create(:item, seller_id: user.id)
        expect do
          delete :destroy, params: { id:item.id }, session: {}
        end.to change(Item, :count).by(-1)

      end
      # 削除に成功した場合root_pathに移動する
      it 'redirects to root_path' do
        login user
        item = create(:item, seller_id: user.id)
        delete :destroy, params: { id:item.id }, session: {}
        expect(response).to redirect_to root_path(user)
      end
    end

    context 'can not delete' do
      # ログイン中ユーザー！＝出品者ユーザーの場合、アイテムを削除できない
      it '@item.seller_id != current_user.id' do
        login user
        category = create(:category)
        item = create(:item, seller_id:100)
        expect do
          delete :destroy, params: { id: item.id }, session: {}
        end.to change(Item, :count).by(0)
      end

      # ログイン中ユーザー！＝出品者ユーザーの場合、アイテムを削除できず、detail_item_pathに飛ぶ
      it "redirect to detail_item_path" do
        login user
        category = create(:category)
        item = create(:item, seller_id:100)
        delete :destroy, params: { id: item.id }, session: {}
        expect(response).to redirect_to detail_item_path(item)
      end
    end
  end
end

