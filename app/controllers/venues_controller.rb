class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list.html.erb" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id }).at(0)
    @the_venue = matching_venues

    render({ :template => "venue_templates/details.html.erb" })
  end

  def create
    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    redirect_to("/venues/#{venue.id}")
  end
  
  def update
    # Parameters: {"query_address"=>"345 N LaSalle", "query_name"=>"Sterling", "query_neighborhood"=>"River North", "the_id"=>"38"}
    the_id = params.fetch("the_id")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.at(0)

    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save
    
    redirect_to("/venues/#{venue.id}")
  end

  def destroy
    # Parameters: {"id_to_delete"=>"37"}
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.at(0)
    venue.destroy

    redirect_to("/venues")
  end

end
