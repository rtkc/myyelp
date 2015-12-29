require 'spec_helper'

describe Business do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:reviews).order("created_at DESC") }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
end