class BitsController < ApplicationController
    def index
    end

    def new
        @bit = Bit.new
    end
end
