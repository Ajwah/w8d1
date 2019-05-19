RSpec.describe Auction, :type => :model do
  it "is valid with valid attributes" do
    expect(Auction.new(title: 'some title')).to be_valid
  end

  it "is not valid without a title" do
    auction = Auction.new(title: nil)
    expect(auction).to_not be_valid
  end

  it "is not valid without a description"
  it "is not valid without a start_date"
  it "is not valid without a end_date"
end