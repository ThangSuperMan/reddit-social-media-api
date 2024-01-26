require 'rails_helper'

RSpec.describe PostImage, type: :model do
  it { should belong_to(:post) }
end
