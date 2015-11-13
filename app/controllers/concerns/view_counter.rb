module ViewCounter
  extend ActiveSupport::Concern

  private

  def increment_counter
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
  end

  def reset_counter
    if session[:counter]
      session[:counter] = 0
    end
  end
end