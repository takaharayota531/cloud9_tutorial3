class SessionsController < ApplicationController
  def new
  end

  def create 
    user=User.find_by(email: params[:session][:email].downcase)
    
    if user&.authenticate(params[:session][:password])
    # if user
      # ユーザログイン後にユーザ情報のページにリダイレクトする
      reset_session  #sessionをリセットして攻撃対策を行う
      log_in user
      redirect_to user
      
    else 
      # エラーメッセージを削除する
    
      flash.now[:danger]='invalid message appeared'
      render 'new', status: :unprocessable_entity
    end
  end
  
  def destroy
    log_out
    redirect_to root_url, status: :see_other
  
  end


end
