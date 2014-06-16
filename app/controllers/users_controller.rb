class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout 'member'

  helper_method :testmethod
  #GET root
  #GET users/login

  def login
    session.destroy
    @user = User.where(userName: params[:userName], passWord: params[:passWord], enabled: true)

    if @user.count > 0
      if @user[0].userName == 'admin'
        redirect_to :controller => 'admins', :action => 'index'
        session[:admin] = params[:userName]
      else
        session[:user] = params[:userName]
        redirect_to :controller => 'members', :action => 'index'
      end
      @user2 = User.find_by_userName(params[:userName])
      session[:id] = @user2.id
      getRoleGrant
    end
  end

  def getRoleGrant
    session.delete(:roles_id)
    session.delete(:grant_id)
    session.delete(:grant_name)
    if session[:id]
    @user = User.find(session[:id])
    @userRole = @user.roles.where(:enabled => true)
    if @userRole.count > 0
      @userRole.each do |userRole|
        (session[:roles_id] ||= []) << userRole.id
      end

    end

    if session[:roles_id] && session[:roles_id].size > 0
      session[:roles_id].each do |roleID|
        @userGrantTemp = Role.find(roleID)
        @userGrant = @userGrantTemp.grants
        @userGrant.each do |grant|
          (session[:grant_id] ||= []) << grant.grant_id
          (session[:grant_name] ||= []) << grant.grant_name
        end
      end
      session[:grant_id].uniq!
      session[:grant_name].uniq!
    end
    # @userGrant = @user.grants
    end
  end

  def permission
    session.delete(:permission_id)
    session[:permission_id]=params[:id]
    #new user_role de goi form_for
    @user_role = UserRole.new
    #tim user can cap quyen
    @userTemp = User.find(session[:permission_id])
    @roles = Role.all
    @roles -= @userTemp.roles.where(:enabled => true)
    @roles -= Role.where(:enabled => false)
    #tim user tra ve collection_select
     @user = User.where(:id=>  session[:permission_id])

    #tim ra cac quyen cua user
    @user_roles = UserRole.where(user_id:  session[:permission_id])


    respond_to do |format|
      format.html
      format.js
    end
  end

  #GET /users/logout
  def logout
    session.destroy
    redirect_to :controller => 'users', :action => 'login'
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @allroles = Role.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def user_by_role
    @allroles = Role.all
    @role_id = params[:role]
    # @roletemp = UserRole.find(params[:role])
    @user_id = UserRole.where(role_id: params[:role])
    #cach 1: dung tap hop cong tap hop
    @users = User.where(id: '-1')
    @user_id.each do |user|
      @users +=  User.where(id: user.user_id)
      # cach 2: dung array# (@users ||= []) << User.find(user.user_id)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # @user = User.find(params[:id])
  end

  def list
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @users = User.all
    @allroles = Role.all
    respond_to do |format|
      if @user.save
        format.html
        format.js
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        # format.json { render :show, status: :created, location: @user }
        @note = true
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @users = User.all
        @allroles = Role.all
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
        format.js
        @note= true
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js

      end
    end
  end

  def deleteCollection
    #get all user to show user list
    @users = User.all
    @allroles = Role.all
    @arr = params[:chk_user]
    #delete user selection
    # @arr.each do |user|
    #   @user = User.find(user)
    #   if @user.destroy
    #     @note = true
    #   end
    # end
    #enabled user selection
    @action = params[:commit]
    @val = params[:rdoAction]
    if @action.upcase == 'ACTION'
      @arr.each do |user|
        @user = User.find(user)
        @user.update(enabled: @val)
        @note = 'User was successfully updated!'
      end
    else
      if @action.upcase =='DELETE SELECTION'
        @arr.each do |user|
            @user = User.find(user)
            @user.destroy
        end
        @note = 'User was successfully destroyed'
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    @users = User.all
    @allroles = Role.all
    respond_to do |format|
      format.html
      format.js
      # format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_id, :name, :address, :userName, :passWord,:passWord_confirmation, :enabled)
    end
end
