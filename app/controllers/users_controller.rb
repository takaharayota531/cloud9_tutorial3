class UsersController < ApplicationController
  before_action  :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit,:update]
  
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
    # @user=User.find(params[:id])
  end

  def update
    # @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:success]="プロフィールの変更に成功しました"
      redirect_to @user
      
      
    else
      render 'edit', status: :unprocessable_entity
    end 
  end
  
  private 
  
  # user属性を必須として、name,email,password,password_confirmationだけを許可するようにしている
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
    
  end
  
  # before filter
  
  def logged_in_user
    unless  logged_in?
      store_location
      
      
      flash[:danger]="ログインしてください"
      redirect_to login_url, status: :see_other
      
      
    end
    
  end
  
  def correct_user 
    @user=User.find(params[:id])
    redirect_to(root_url,status: :see_other) unless current_user?(@user)
  end
  
end
