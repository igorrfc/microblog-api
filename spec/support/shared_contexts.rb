require './spec/support/shared_contexts/user_authenticated'

RSpec.configure do |rspec|
  rspec.include_context 'user authenticated', include_shared: true
end
