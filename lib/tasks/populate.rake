namespace :db do
	desc "Populate database with nice smaple data"
	task :populate => :environment do
    require 'populator'
    require 'forgery'

    Organization.populate 5 do |org|
    	org.name = Forgery::Name.full_name
    	org.about = Populator.sentences(1)
    	org.location = Forgery::Address.state
    	org.contact = Forgery::Internet.email_address
    	Event.populate 0..20 do |event|
    		event.name = Populator.words(1..3).titleize
    		event.about = Populator.sentences(1..2)
    		event.organization_id = org.id 
    		event.location = Forgery::Address.state
    		random_date = Forgery::Date.date
    		event.start = random_date
    		event.end = random_date + rand(3)
    		Team.populate 0..20 do |team|
    			team.name = Populator.words(1..3).titleize
    			team.event_id = event.id 
    		end # /team
    	end # /event
    end # /org

    # Create some users for login
    gant = User.all.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa")
    moke = User.all.where(email: "themoke@gmail.com").first_or_create(password: "fdsafdsa")
    cbrou = User.all.where(email: "daddymac@gmail.com").first_or_create(password: "fdsafdsa")
  end	
end