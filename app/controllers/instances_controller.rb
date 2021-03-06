class InstancesController < ApplicationController
  before_action :set_instance, only: [:show]
  helper_method :sort_column, :sort_direction

  # GET /instances
  # GET /instances.json
  def index
    @instances = Instance.head
    if params[:search]
      term = "%#{params[:search]}%"
      @instances = @instances.where("name ILIKE ? OR instances.instance_id ILIKE ? OR public_ip_address ILIKE ? OR \
      private_ip_address ILIKE ? OR public_dns_name ILIKE ? OR vpc_id ILIKE ? OR subnet_id ILIKE ?",\
      term, term, term, term, term, term, term)
    end
    if params[:sort]
      @instances = @instances.order(params[:sort] + ' ' + params[:direction])
    end
  end

  # GET /instances/1
  # GET /instances/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance
      @instance = Instance.find(params[:id])
    end

  private
    def sort_column
      Instance.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end
