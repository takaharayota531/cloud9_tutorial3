class UsersController < ApplicationController
  
  def show
    @user=User.find(params[:id])
    # debugger
  end
  
  def new
    @user=User.new
  end
  
  def create
    # @user=User.new(params[:id])
    @user=User.new(user_params)
    
    if @user.save
      # session固定攻撃に対応している
      reset_session
      
      log_in @user
      
      flash[:success] = "user registration succeded"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  def edit
    @user=User.find(params[:id])
  end
  
  private 
  
  # user属性を必須として、name,email,password,password_confirmationだけを許可するようにしている
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
    
  end
  
end
