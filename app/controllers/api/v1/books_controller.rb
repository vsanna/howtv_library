class Api::V1::BooksController < ApplicationController
  before_filter :authenticate_user!

  def index_or_search
    if params[:query][:search_key].blank?
      @books = Book.all.paginate(page: params[:page])
    elsif
      @books = Book.search({
                      title_or_author_or_publisher_cont: params[:query][:search_key]
                   }).result.paginate(page: params[:page])
    end
    set_count @books
  end

  def show
    @book = Book.find(params[:id])
    @comments = @book.comments
  end

  private
  def set_count job_infos
    @total =  job_infos.count
    @left_count = @total - (params[:page].to_i) * 30 # 1ページにつき30件返す
  end
end
