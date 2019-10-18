class TestsController < ApplicationController
  def index
    @test = Test.new
    @tests = Test.all
  end

  def create
    @test = Test.new(test_params)
    @test.save
    redirect_to tests_path
  end

  private

  def test_params
    params.require(:test).permit(:image)
  end
end
