class SessionsController < ApplicationController
  def new
  end

  def create 
    user=User.find_by(email: params[:session][:email].downcase)
    
    if user&.authenticate(params[:session][:password])
    # if user
      forwarding_url=session[:forwarding_url]
      # ユーザログイン後にユーザ情報のページにリダイレクトする
      reset_session  #sessionをリセットして攻撃対策を行う
      params[:session][:remember_me]=='1'? remember(user) : forget(user)
      remember user
      log_in user
      redirect_to  forwarding_url || user
      
    else 
      # エラーメッセージを削除する
    
      flash.now[:danger]='invalid message appeared'
      render 'new', status: :unprocessable_entity
    end
  end
  
  def destroy
    # 複数ブラウザでのログアウトログイン周りのエラーを修正
    log_out if logged_in?
    
    redirect_to root_url, status: :see_other
  
  end


end
