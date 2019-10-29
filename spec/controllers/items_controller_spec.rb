require 'rails_helper'

describe ItemsController do

  # describe 'DELETE destroy' do
  #   let(:user) { create(:user) }
  #   context 'can delete' do
  #     # ログイン中ユーザー＝出品者ユーザーの場合、アイテムを削除できる
  #     it '@item.seller_id == current_user.id' do
  #       login user
  #       category = build(:category)
  #       item = create(:item, seller_id: user.id)
  #       # binding.pry

  #       # categorie = create(:category)
  #       expect do
  #         delete :destroy, params: { id:item.id }, session: {}
  #       end.to change(Item, :count).by(-1)

  #     end
  #     # 削除に成功した場合root_pathに移動する
  #     it 'redirects to root_path' do
  #       login user
  #       category = build(:category)
  #       item = create(:item, seller_id: user.id)
  #       delete :destroy, params: { id:item.id }, session: {}
  #       expect(response).to redirect_to root_path(user)
  #     end
  #   end

  #   context 'can not delete' do
  #     # ログイン中ユーザー！＝出品者ユーザーの場合、アイテムを削除できない
  #     it '@item.seller_id != current_user.id' do
  #       login user
  #       category = build(:category)
  #       item = create(:item, seller_id:100)
  #       expect do
  #         delete :destroy, params: { id: item.id }, session: {}
  #       end.to change(Item, :count).by(0)
  #     end

  #     # ログイン中ユーザー！＝出品者ユーザーの場合、アイテムを削除できず、detail_item_pathに飛ぶ
  #     it "redirect to detail_item_path" do
  #       login user
  #       category = build(:category)
  #       item = create(:item, seller_id:100)
  #       delete :destroy, params: { id: item.id }, session: {}
  #       expect(response).to redirect_to detail_item_path(item)
  #     end
  #   end
  # end


  describe 'GET index' do
    let(:user) { build(:user) }
    let(:categorie) { build(:categorie) }

    context 'index assigns and render check ' do

      it 'assigns @items' do
        items = create_list(:item, 5)
        get :index
        expect(assigns(:items)).to eq(items)
      end

      it 'assigns @ladies_items' do
        expect(assigns(:item)).to eq group
      end

      it 'assigns @mens_items' do
        expect(assigns(:item)).to eq group
      end

      it 'assigns @electrical_appliance_items' do
        expect(assigns(:item)).to eq group
      end

      it 'assigns @toy_hobby_items' do
        expect(assigns(:item)).to eq group
      end

      it 'redners index' do
        expect(response).to render_template :index
      end

    end
  end

end


# 参考コード

# describe 'GET #index' do
#   # @itemsという変数が正しく定義されているか
#   it "assigns the requested items to @items" do
#     @items = create_list(:item, 5)
#     get :index
#     expect(assigns(:items)).to eq(@items)
#   end

#   # 該当するビューが描画されているか
#   it "renders the :index template" do
#     get :index
#     expect(response).to render_template :index
#   end
# end
