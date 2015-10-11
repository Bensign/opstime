require 'rubygems'
require 'droplet_kit'
require 'singleton'

require 'opstime/version'

module Opstime

  class << self
    attr_accessor :application_token, :do_client, :region

    # Initialize the Opstime gem
    def init(options={})
      self.application_token = options[:application_token] if options[:application_token].present?
      intialize_digital_ocean_api_connection
    end

    # Given a particular pool name, do all the heavy liftening around scaling up and down of that particular
    # cluster of servers.
    def scale_to(pool_name, target_num_servers)
      current_server_count = current_pool_size(pool_name)
      if target_num_servers > current_server_count
        remove_servers(pool(pool_name)[target_num_servers..-1])
      else
        add_additional_servers(pool_name, target_num_servers - current_server_count)
      end
    end

    # A helper for access all of the servers which exist in a particular pool
    def pool(pool_name)
      matched_servers = []
      do_client.droplets.all.each do |server|
        matched_servers << server if server.name.include?(pool_name)
      end
      return matched_servers
    end

    # A Helper for determining how many servers currently exist in this "pool"
    # Since Digital Ocean doesn't currently support tagging of servers, this is
    # currently done by doing a hazy match on the name of the server.
    def current_pool_size(pool_name)
      pool(pool_name).count
    end

    def add_additional_servers(n=0)
      n.times do |time|
        # Spin up droplet based off of user preferences
        #droplet = DropletKit::Droplet.new(name: 'mysite.com', region: 'nyc2', image: 'ubuntu-14-04-x64', size: '512mb')
      end
    end

    # Given a list of server, go ahead and cycle through to delete them
    def remove_servers(servers_to_destroy=[])
      servers_to_destroy.each do |server|
        puts "Destroying..." + server.id
        do_client.droplets.destroy(:id => server.id)
      end
    end


    # Helper method for initializing a connection with the DigitalOcean API
    def intialize_digital_ocean_api_connection
      if self.application_token.nil?
        raise "Please assign opstime an application token.  You can get an application token from https://cloud.digitalocean.com/settings/applications"
      else
        self.do_client = DropletKit::Client.new(:access_token => self.application_token)
      end
    end
  end
end
