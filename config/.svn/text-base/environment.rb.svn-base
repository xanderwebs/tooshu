# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tooshu::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if instance.error_message.kind_of?(Array)
    #%(<span class="">#{html_tag}#{instance.error_message.join(',')}</span>).html_safe    
    %(#{html_tag}<span class="validation-error">&nbsp;#{instance.error_message.join(',')}</span>).html_safe
  else
    #%(<span class="">#{html_tag}#{instance.error_message.full_message}</span>).html_safe
    %(#{html_tag}<span class="validation-error">&nbsp;#{instance.error_message.full_message}</span>).html_safe
  end
end