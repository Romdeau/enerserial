module ApplicationHelper
  def format_name(user_email)
    @name_array = user_email.split("@")
    @name_array = @name_array[0].split(".")
    @fullname = ''
    @name_array.each do |user_name|
      @fullname = @fullname + user_name.capitalize + ' '
    end
    @fullname
  end
end
