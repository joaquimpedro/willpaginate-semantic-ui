class IndexController < ApplicationController
    def index
        @list = ['item 1', 'item 2', 'item 3', 'item 4', 'item 5', 'item 6', 'item 7', 'item 8'].paginate(:page => params[:page], :per_page => 1)
    end
end
