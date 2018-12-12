class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    @tweet = Tweet.find(params[:tweet_id])
    @comments = @tweet.comments.order_by(created_at: :desc)
    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @tweet = Tweet.where({_id: params[:tweet_id]}).last
    @comment = @tweet.comments.build(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @tweet.comments.destroy(@comment)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @tweet = Tweet.where({_id: params[:tweet_id]}).last
      @comment = @tweet.comments.where({_id: params[:id]})
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.fetch(:comment, {}).permit(:text)
    end
end
