class ApiController < ApplicationController
  def index
    @bills = []
    if params[:search]
      @search = params[:search]
      @client = HTTPClient.new
      @uri = "https://api.propublica.org/congress/v1/114/senate/bills/introduced.json"
      @key = ENV['X_API_KEY']
      @response = @client.get(@uri, :query => {:search => @search }, :header => { :"X-API-Key" => @key, :"Accept" => 'application/json'}).body
      @parsed = JSON.parse(@response)
      @parsed.each do |body|
        @bills << body
      end
    end
    @bill = Bill.new
  end
end
