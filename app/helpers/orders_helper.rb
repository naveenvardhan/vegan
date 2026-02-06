module OrdersHelper
  def status_color(status)
    case status
    when 'pending' then 'danger'
    when 'accepted' then 'info'
    when 'completed' then 'success'
    when 'rejected' then 'warning'
    else 'secondary'
    end
  end
end