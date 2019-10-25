require 'rails_helper'
describe Item do
  describe '#create' do
    it "is valid all data" do
      category = Category.create(id: 1, name: "")
      item = build(:item, category_id: category.id)
      item.valid?
      expect(item).to be_valid
    end
    it "is invalid without a item_status" do
      item = build(:item,item_status:nil)
      item.valid?
      expect(item.errors[:item_status]).to include("can't be blank")
    end
    it "is invalid without a delivery_charged" do
      item = build(:item,delivery_charged:nil)
      item.valid?
      expect(item.errors[:delivery_charged]).to include("can't be blank")
    end
    it "is invalid without a delivery_method" do
      item = build(:item,delivery_method:nil)
      item.valid?
      expect(item.errors[:delivery_method]).to include("can't be blank")
    end
    it "is invalid without a delivery_area" do
      item = build(:item,delivery_area:nil)
      item.valid?
      expect(item.errors[:delivery_area]).to include("can't be blank")
    end
    it "is invalid without a delivery_shipping_date" do
      item = build(:item,delivery_shipping_date:nil)
      item.valid?
      expect(item.errors[:delivery_shipping_date]).to include("can't be blank")
    end
    it "is invalid without a total_price" do
      item = build(:item,total_price:nil)
      item.valid?
      expect(item.errors[:total_price]).to include("can't be blank")
    end
    it "is invalid without a total_price" do
      item = build(:item,total_price:nil)
      item.valid?
      expect(item.errors[:total_price]).to include("can't be blank")
    end
    it "is invalid without a item_profile_comment" do
      item = build(:item,item_profile_comment:nil)
      item.valid?
      expect(item.errors[:item_profile_comment]).to include("can't be blank")
    end
    it "is invalid without a category_id" do
      item = build(:item,category_id:nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end
  end
end