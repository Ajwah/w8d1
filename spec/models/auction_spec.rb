RSpec.describe Auction, :type => :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.title = "some title"
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    expect(subject).to_not be_valid
  end

  it "is not valid without a description"
  it "is not valid without a start_date"
  it "is not valid without a end_date"
end