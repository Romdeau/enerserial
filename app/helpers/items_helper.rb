module ItemsHelper
  def format_item_serial(item)
    if item.item_serial == nil
      'TBA'
    else
      item.item_serial
    end
  end
end
