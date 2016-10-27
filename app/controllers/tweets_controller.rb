class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :update, :destroy]
  
  def index
    @count = Tweet.count
    @tweets = Tweet.all.order(id: :desc)
  end
  
  def new
    if params[:back]
      @tweet = Tweet.new(tweets_params)
    else
      @tweet = Tweet.new
    end
  end
  
  def create
    @tweet = Tweet.new(tweets_params)
    if params[:back]
      render action: 'new'
    elsif @tweet.save
      redirect_to tweets_path, notice: "あらたなひとりごとを記憶しました。"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @tweet.update(tweets_params)
      redirect_to tweets_path, notice: "なおしたひとりごとを記憶しました。"
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "ひとりごとを一つ、わすれさりました。"
  end
  
  def confirm
    @tweet = Tweet.new(tweets_params)
    render :new if @tweet.invalid?
  end
  
  private
    def tweets_params
      params.require(:tweet).permit(:content)
    end
    
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
end
