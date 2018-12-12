class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user!, raise: false, only: [:index]

  # GET /tweets
  def index
    @tweets = Tweet.all.order_by(created_at: :desc)
    render json: @tweets, include: [:user]
  end

  # GET /tweets/1
  def show
    render json: @tweet
  end

  # POST /tweets
  def create
    p tweet_params
    @tweet = Tweet.new(tweet_params)

    if @tweet.save
      render json: @tweet, status: :created, location: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tweets/1
  def update
    if @tweet.update(tweet_params)
      render json: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy
  end

  def search
    @tweets = Tweet.full_text_search(params[:search]).desc(:created_at)
    render json: @tweets, include: [:user]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tweet_params
      params.fetch(:tweet, {}).permit(:text, :user)
    end
end
