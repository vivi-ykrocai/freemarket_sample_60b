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
  describe 'GET #show' do
    # @itemの値が期待したものになるか。
    it "assigns the requested item to @item" do
      item = create(:item)
      get :show, params: { id: item.id }
      expect(assigns(:item)).to eq item
    end

    # @user_itemsの値が期待したものになるか。
    it "assigns the requested user_items to @user_items" do
      item = create(:item)
      user_items = create_list(:item, 3)
      get :show, params: { id: item.id }
      expect(assigns(:user_items)).to eq user_items=[]
    end

    # showアクションが動いた後、該当のビュー(show.html.haml)に遷移するか。
    it 'renders the :show template' do
      item = create(:item)
      get :show, params: { id: item.id }
      expect(response).to render_template :show
    end
  end


  # 商品編集機能
  describe 'GET #edit' do

    it 'has a 200 status code' do
      get :edit, params: { id: 1 }
      expect(response).to have_http_status(200)
    end
    it "assigns the requested item to @item" do
      item = create(:item)
      get :edit, params: {id: item.id}
      expect(assigns(:item)).to eq item
    end
    it "renders the :edit template" do
      item = create(:item)
      get :edit, params: {id: item.id}
      expect(response).to render_template :edit
    end
  end

  # 商品更新
  describe 'PATCH #update' do
    let(:user) { create(:user) }
    context 'can update' do
      it 'item can update' do
        item = create(:item)
        update_attributes = {delivery_area: '北海道'}
        login user
        patch :update, params: {id: item.id, item: update_attributes}
        expect(item.reload.delivery_area).not_to eq '東京都'
      end
    end
      it 'redirect_to detail_item_path(@item)' do
        item = create(:item)
        update_attributes = {delivery_area: '北海道'}
        login user
        patch :update, params: {id: item.id, item: update_attributes}
        expect(response).to redirect_to detail_item_path(item)
      end

    context 'can not update' do
      it 'can not update' do
        item = create(:item)
        update_attributes = {delivery_area: ''}
        login user
        patch :update, params: {id: item.id, item: update_attributes}
        expect(item.reload.delivery_area).to eq '東京都'
      end
    end
  end
end

