module SkisHelper

  def skis_chart_series(skis)
      skis_by_size = skis.group("ski_size_id").select("ski_size_id, count(id) as total_skis")
      SkiSize.all.map do |size|
        ski = skis_by_size.detect { |ski| ski.ski_size == size }
        ski && ski.total_skis.to_f || 0
      end.inspect
  end
    
  def ski_size_options
    ['130-139', '140-149', '150-159', '160-169', '170-179', '180-189', '> 190']
  end
  
  def ski_condition_options
    ['Poor', 'Acceptable', 'Good', 'Very Good', 'New']
  end
  
  def ski_brand_options
    ['Atomic', 'Dalbello', 'Fischer', 'Head', 'Lange', 'Nordica', 'Rossignol', 'Scarpa', 'Solomon', 'Tecnica', 'Other']
  end
    
  def ski_suggested_number
    @numbers_temp = Array.new
    if current_store.skis 
        current_store.skis.each do |ski|
        @numbers_temp << ski.number
      end
    end 
    
    if current_store.skis.size > 0
      if @numbers_temp.inject(0){|sum, item| sum + item} == (@numbers_temp.min + @numbers_temp.max)*@numbers_temp.max/2
        current_store.skis.size + 1
      else
        @array_temp = Array(1..@numbers_temp.max)
        @available = @array_temp - @numbers_temp
        @available.min.to_i
      end    
    else
      1
    end
  end
  
end
