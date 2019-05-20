RSpec.describe Auction, :type => :model do
  let(:invalid_title) { nil }
  let(:invalid_description) { nil }
  let(:invalid_date) { nil }

  subject {
    described_class.new(title: "Anything", description: "Lorem ipsum",
                      start_date: DateTime.now, end_date: DateTime.now + 1.week)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = @invalid_title
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = @invalid_description
    expect(subject).to_not be_valid
  end

  it "is not valid without a start_date" do
    subject.start_date = @invalid_date
    expect(subject).to_not be_valid
  end
  
  it "is not valid without a end_date" do
    subject.end_date = @invalid_date
    expect(subject).to_not be_valid
  end
end
