class RoleGrantsController < ApplicationController
  before_action :set_role_grant, only: [:show, :edit, :update, :destroy]

  # GET /role_grants
  # GET /role_grants.json
  def index
    @role_grants = RoleGrant.all
    @arr = @arr
  end

  def getGrant
    @getGrant = RoleGrant.where
  end

  # GET /role_grants/1
  # GET /role_grants/1.json
  def show
  end

  # GET /role_grants/new
  def new
    @role_grant = RoleGrant.new
    @role = Role.all
    @grant = Grant.all
  end

  # GET /role_grants/1/edit
  def edit
  end

  # POST /role_grants
  # POST /role_grants.json
  def create

    @arr = params[:grant_id]
      @arr.each do |grant|
        @role_grant = RoleGrant.new(:role_id => params[:role_grant][:role_id], :grant_id => grant)
          if @role_grant.save
            #new role_grant de goi form_for
            @role_grant = RoleGrant.new
            #tim role can cap quyen
            @roleTemp = Role.find(session[:addGrant_id])
            @grants = Grant.all
            @grants -= @roleTemp.grants
            @role = Role.where(id: session[:addGrant_id])

            #tim ra cac grant cua role
            @role_grants = RoleGrant.where(role_id: session[:addGrant_id])
            @note = 'Inserted!'
          end
      end
        respond_to do |format|
          format.html {}
          format.js
        end
  end

  # PATCH/PUT /role_grants/1
  # PATCH/PUT /role_grants/1.json
  def update
    respond_to do |format|
      if @role_grant.update(role_grant_params)
        format.html { redirect_to @role_grant, notice: 'Role grant was successfully updated.' }
        format.json { render :show, status: :ok, location: @role_grant }
      else
        format.html { render :edit }
        format.json { render json: @role_grant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_grants/1
  # DELETE /role_grants/1.json
  def destroy
    if @role_grant.destroy
      #tim role can cap quyen
      @roleTemp = Role.find(session[:addGrant_id])
      @grants = Grant.all
      @grants -= @roleTemp.grants
      @role = Role.where(id: session[:addGrant_id])

      #tim ra cac grant cua role
      @role_grants = RoleGrant.where(role_id: session[:addGrant_id])
      @note = 'Deleted!'
    end
    respond_to do |format|
      format.html
      format.js
      # format.html { redirect_to role_grants_url, notice: 'Role grant was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_grant
      @role_grant = RoleGrant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_grant_params
      #params[:role_grant]
      params.require(:role_grant).permit(:role_id, :grant_id)
    end
end
