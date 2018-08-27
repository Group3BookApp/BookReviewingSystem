class StaticPagesController < ApplicationController
  def home
    @new_update_books = Book.order(created_at: :desc).take Settings.new_update_books
    @top_rating_books = Book.take Settings.new_update_books
    @top_read_books = Book.take Settings.new_update_books
  end

  def help; end

  def about; end

  def contact; end
end
