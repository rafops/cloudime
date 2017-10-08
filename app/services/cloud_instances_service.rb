class CloudInstancesService
  def initialize(profile: nil, region: nil, **options)
    client_options = {}
    credentials = Aws::SharedCredentials.new(profile_name: profile) if profile
    client_options.merge!(credentials: credentials) if credentials
    client_options.merge!(region: region) if region
    client_options.merge!(options)
    @client = Aws::EC2::Client.new(client_options)
  end

  def regions
    @client.describe_regions.regions.map { |r| r.region_name }
  end

  protected

  attr_reader :client
end