# Module that allows some transactions over DB resources on a safer way
module SecureTransaction
  extend ActiveSupport::Concern

  FAILING_MESSAGE = 'The action you were trying to access is no longer available!'.freeze

  # Method wich fetches a DB resource on a safer way, handling an Active record exception and
  # redirecting to the homepage with a generic failure notice message, or returning the
  # resource in case that no errors have been arisen during the transaction

  def find(origin_resource, id)
    begin
      origin_resource.find(id)
    rescue ActiveRecord::ActiveRecordError # Generalize an error incoming from ActiveRecord
      redirect_to root_path, notice: FAILING_MESSAGE
    end
  end

  ## Here we've the proc intention
  # @@FIND = proc { |origin_resource, id|
  # begin
  #   origin_resource.find(id)
  # rescue ActiveRecord::ActiveRecordError # Generalize an error incoming from ActiveRecord
  #   return redirect_to root_path, notice: FAILING_MESSAGE
  # end
  # }

end
