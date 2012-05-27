namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    @boot_stock      = 100
    @ski_stock       = 100
    @customer_total  = 100
    @days_ago        = 90
    @avg_no_packages = 2
    @avg_length      = 3
    
    [Customer, Package, Boot, Ski, Rental].each(&:delete_all)

    Boot.populate @boot_stock do |boot|
      boot.number           = boot.id
      boot.brand            = ['Atomic', 'Dalbello', 'Fischer', 'Head', 'Lange', 'Nordica', 'Rossignol', 'Scarpa', 'Solomon', 'Tecnica', 'Other']
      boot.condition        = ['Poor', 'Acceptable', 'Good', 'Very Good', 'New']
      boot.store_id         = [2]
      boot.in_store         = [1]
      boot.available        = [1]
      boot.boot_size_id     = [1,2,3,4,5,6,7,8,9,10,11,12,13,14]
    end
      
    Ski.populate @ski_stock do |ski|
      ski.number            = ski.id
      ski.brand             = ['Atomic', 'Dalbello', 'Fischer', 'Head', 'Lange', 'Nordica', 'Rossignol', 'Scarpa', 'Solomon', 'Tecnica', 'Other']
      ski.condition         = ['Poor', 'Acceptable', 'Good', 'Very Good', 'New']
      ski.store_id          = [2]
      ski.in_store          = [1]
      ski.available         = [1]
      ski.ski_size_id       = [1,2,3,4,5,6,7]
    end
    
    Customer.populate @customer_total do |customer|
      customer.store_id     = [2]
      customer.first_name   = Faker::Name.first_name
      customer.last_name    = Faker::Name.last_name
      customer.country      = Faker::Address.earth_country
      customer.phone        = Faker::PhoneNumber.phone_number
      customer.hotel        = Faker::Company.name
        Package.populate 1..@avg_no_packages do |package|
          package.customer_id = customer.id
          days_offset_start   = Random.rand(1..@days_ago)
          lenght              = Random.rand(1..@avg_length)
          package.start_date  = (rand(days_offset_start - days_offset_start) + days_offset_start).days.ago..Time.now
          package.end_date    = package.start_date + (rand(lenght - lenght) + lenght).days
            if package.end_date < Date.today
              package.status    = ['expired']
            else 
              package.status    = ['in', 'out']
            end
          boot_number         = Random.rand(1..@boot_stock)
            until Boot.where(:number => boot_number).first.available == true
              boot_number       = Random.rand(1..@boot_stock)
            end     
          ski_number          = Random.rand(1..@ski_stock)
            until Ski.where(:number => ski_number).first.available == true
              ski_number        = Random.rand(1..@ski_stock)
            end             
          package.ski_id      = Boot.where(:number => boot_number).first.id
          package.boot_id     = Boot.where(:number => ski_number).first.id
        
            if (([package.end_date, Time.now].min - package.start_date)/3600/24).floor != 0
              plan_dur        = (([package.end_date, Time.now].min - package.start_date)/3600/24).floor
            else 
              plan_dur        = 1
            end          
            used_days         = Random.rand(1..plan_dur)
          
          used_days.times do |rent_day|  
                 
            Rental.populate 1 do |rental|
            rental.package_id = package.id
            rental.in_or_out  = 'out'
            rental.time       = package.start_date + rent_day.days + Random.rand(1..6).hours + Random.rand(1..50).minutes       
              @ski            = Ski.where(:id => package.ski_id ).first
              @ski.available  = false
              @ski.in_store   = false
              @ski.save
              @boot           = Boot.where(:id => package.boot_id ).first
              @boot.available = false
              @boot.in_store  = false
              @boot.save          
            end # end checkout
          
            Rental.populate 1 do |rental|
            rental.package_id = package.id
            rental.in_or_out  = 'in'  
            rental.time       = package.start_date + rent_day.days + Random.rand(12..20).hours + Random.rand(1..50).minutes  
              @ski            = Ski.where(:id => package.ski_id ).first
              @ski.available  = false
              @ski.in_store   = true
              @ski.save
              @boot           = Boot.where(:id => package.boot_id ).first
              @boot.available = false
              @boot.in_store  = true
              @boot.save        
            end   # end checkin
          
          end # end rentals 
        
          if package.status     == 'out'
              Rental.populate 1 do |rental|
              rental.package_id = package.id
              rental.in_or_out  = 'out'
              rental.time       = Date.today + 2.day 
                @ski            = Ski.where(:id => package.ski_id ).first
                @ski.available  = false
                @ski.in_store   = false
                @ski.save
                @boot           = Boot.where(:id => package.boot_id ).first
                @boot.available = false
                @boot.in_store  = false
                @boot.save          
              end # end checkout for current packages
          end 
                
               
        end # end package
        # if package.status == 'expired'      
        #   @ski            = Ski.where(:id => package.ski_id ).first
        #   @ski.available  = true
        #   @ski.save
        #   @boot           = Boot.where(:id => package.boot_id ).first
        #   @boot.available = true
        #   @boot.save
        # end
    end # end customer    
    
    


  end
end