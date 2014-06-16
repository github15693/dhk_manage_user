require 'users_controller'
class UserRolesController < ApplicationController
  before_action :set_user_role, only: [:show, :edit, :update, :destroy]
  include UsersHelper
  # GET /user_roles
  # GET /user_roles.json
  def index
    @user_roles = UserRole.all
  end


  def getRole
    @user_roles = UserRole.all
    @user = User.all
    @role = Role.all
    @getRoles = UserRole.where(user_id: session[:id])
    session.delete(:roles)
  end

  # GET /user_roles/1
  # GET /user_roles/1.json
  def show
  end

  # GET /user_roles/new
  def new
    @user_role = UserRole.new
    @user = User.all
    @role = Role.all
  end

  # GET /user_roles/1/edit
  def edit
  end

  # POST /user_roles
  # POST /user_roles.json
  def create
    @arr = params[:role_id]
    for i in 0..@arr.size-1
      @user_role = UserRole.new(:user_id => params[:user_role][:user_id], :role_id => @arr[i])

        if @user_role.save

          @user_role = UserRole.new
          #tim user can cap quyen
          @userTemp = User.find(session[:permission_id])
          @roles = Role.all
          @roles -= @userTemp.roles.where(:enabled => true)
          @roles -=Role.where(:enabled => false)
          @user = User.where(:id=> session[:permission_id])

          #tim ra cac quyen cua user
          @user_roles = UserRole.where(user_id:  session[:permission_id])
        end
    end

    respond_to do |format|
      # format.html

      format.js
      # format.json { render :show, status: :created, location: @role_grant }
      # else
      #   format.html {}
      # format.json { render json: @role_grant.errors, status: :unprocessable_entity }
    end

    # @user_role = UserRole.new(user_role_params)
    #
    # respond_to do |format|
    #   if @user_role.save
    #     format.html { redirect_to @user_role, notice: 'User role was successfully created.' }
    #     format.json { render :show, status: :created, location: @user_role }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user_role.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /user_roles/1
  # PATCH/PUT /user_roles/1.json
  def update
    respond_to do |format|
      if @user_role.update(user_role_params)
        format.html { redirect_to @user_role, notice: 'User role was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_role }
      else
        format.html { render :edit }
        format.json { render json: @user_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_roles/1
  # DELETE /user_roles/1.json
  def destroy
    @user_role.destroy
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
      # format.html { redirect_to user_roles_url, notice: 'User role was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_role
      @user_role = UserRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_role_params
      params[:user_role]
    end
end
