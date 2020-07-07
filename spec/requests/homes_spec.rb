require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /" do
    context "when not loged in" do
      it "render to login form" do
        get root_path
        expect(response.status).to eq(200)
        expect(response.body).to include("Please sign up at first!")
      end
    end

    context "when loged in" do
      it "render to blogs path" do
        log_in
        get root_path
        expect(response.status).to eq(200)
        expect(response.body).to include("Go to blogs")
      end
    end
  end
end
