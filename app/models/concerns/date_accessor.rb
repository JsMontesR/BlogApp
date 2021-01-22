# Module responsible for detailing the Date reading
# format of the timestamp of the model who includes it
module DateAccessor
  DATE_FORMAT = '%d/%m/%Y at %I:%M:%S - %p'.freeze

  def created_date
    created_at.strftime(DATE_FORMAT)
  end

  def updated_date
    updated_at.strftime(DATE_FORMAT)
  end

end
