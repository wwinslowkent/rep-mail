class ApiController < ApplicationController
  def index
    @bills = []
    if params[:search]
      @search = params[:search]
      @client = HTTPClient.new
      @uri = "https://igdbcom-internet-bill-database-v1.p.mashape.com/bills/?fields=*&limit=20&offset=0"
      @key = ENV['XMASHAPE_KEY']
      @response = @client.get(@uri, :query => {:search => @search }, :header => { :"X-Mashape-Key" => @key, :"Accept" => 'application/json'}).body
      @parsed = JSON.parse(@response)
      @parsed.each do |body|
        if (body['cover']) && (body['name']) && (body['summary'])
          @bills << body
        end
      end
    end
    @bill = Bill.new
  end
end
