class BitsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @bits = Bit.all
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
        return user_ability if @bit.user != current_user
    end

    def update
        @bit = Bit.find_by_id(params[:id])
        return render_not_found if @bit.blank?
        return user_ability if @bit.user != current_user

        @bit.update_attributes(bit_params)
        
        if @bit.valid?
            redirect_to root_path
        else
            return render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @bit = Bit.find_by_id(params[:id])
        return render_not_found if @bit.blank?
        return user_ability if @bit.user != current_user
        @bit.destroy
        redirect_to root_path
    end
    
    private

    def bit_params
        params.require(:bit).permit(:message, :pics)
    end

    def render_not_found
        render plain: 'Not Found :(', status: :not_found
    end

    def user_ability
        render plain: 'Forbidden :(', status: :forbidden 
    end
end


