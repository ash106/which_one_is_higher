class StaticPagesController < ApplicationController
  def home
  end

  def about
    # @ip_info = IpInfo.new().get_ip_info "184.172.143.212"
    # @elevation = Elevation.new.get_elevation_for @ip_info
  end
end
