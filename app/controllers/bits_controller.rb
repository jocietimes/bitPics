class BitsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
    end

    def new
        @bit = Bit.new
    end

    def create
        @bit = current_user.bits.create(bit_params)
        if @bit.valid?
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @bit = Bit.find_by_id(params[:id])
        return render_not_found if @bit.blank?
    end

    def edit
        @bit = Bit.find_by_id(params[:id])
        return render_not_found if @bit.blank?
    end

    def update
        @bit = Bit.find_by_id(params[:id])
        return render_not_found if @bit.blank?

        @bit.update_attributes(bit_params)
        
        if @bit.valid?
            redirect_to root_path
        else
            return render :edit, status: :unprocessable_entity
        end
    end
    
    private

    def bit_params
        params.require(:bit).permit(:message)
    end

    def render_not_found
        render plain: 'Not Found :(', status: :not_found
    end
end


