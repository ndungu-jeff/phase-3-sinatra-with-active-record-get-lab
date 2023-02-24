class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  # add routes
  get '/bakeries' do
    # get all the bakeries from the database
    bakeries = Bakery.all
    # send them back as a JSON array
    bakeries.to_json
  end
  get '/bakeries/:id' do
    bakery= Bakery.find(params[:id])
    bakery.to_json(only:[:name], include:{
      baked_goods: {only: [:name, :price]}
    })

  end
  get "/baked_goods/by_price" do
    goods= BakedGood.order(price: :desc)
    goods.to_json
  end
  get "/baked_goods/most_expensive" do
    goods= BakedGood.order(price: :desc)[0]
    goods.to_json
  end

end
