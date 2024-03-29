class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: :uplist

  # GET /domains
  # GET /domains.json
  def index
    @domains = Domain.all
  end

  def show
  end

  def new
    @domain = Domain.new
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      main_domain = DomainService.generate_parent_domain(domain_params[:name]) if params[:main_domain].blank?

      if main_domain.present?
        @domain = Domain.create(name: domain_params[:name], main_domain: main_domain.id)
      else
        @domain = Domain.create(name: domain_params[:name], main_domain: params[:main_domain])
      end

      respond_to do |format|
        if @domain.save
          format.html { redirect_to domains_path, notice: 'Domain was successfully created.' }
          format.json { render :show, status: :created, location: @domain }
        else
          format.html { render :new }
          format.json { render json: @domain.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @domain }
      else
        format.html { render :edit }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      DomainService.cascade_destroy(@domain)
      @domain.destroy
      respond_to do |format|
        format.html { redirect_to domains_url, notice: 'Domain was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def uplist
    uplist_output = DomainService.domain_file(params[:upload_domains])
    redirect_to domains_path, notice: uplist_output
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:name, :main_domain)
    end
end
