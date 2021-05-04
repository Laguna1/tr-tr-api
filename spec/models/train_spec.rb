require 'rails_helper'

RSpec.describe Train, type: :model do
  # Association test
  # ensure Train model has a 1:m relationship with the Track model
  it { should have_many(:tracks).dependent(:destroy) }
  # Validation tests
  # ensure columns name and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end
