require 'rails_helper'

RSpec.describe Track, type: :model do
  # Association test
  # ensure an track record belongs to a single train record
  it { should belong_to(:train) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
