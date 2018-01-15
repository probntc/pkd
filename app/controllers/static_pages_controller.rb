class StaticPagesController < ApplicationController
  def show
    if valid_page? && check_page?
      render "static_pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist? Pathname.new(Rails.root + "app/views/static_pages/#{params[:page]}.html.erb")
  end

  def check_page?
    check_list = %w(home about help contact)
    check_list.include? "#{params[:page]}"
  end
end
