class HomeController < ApplicationController
  def index
    @surveys = Survey.limit(3)
  end
end
