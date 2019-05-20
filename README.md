# Testing your patience with RSpec

In the lecture title of today, I acknowledged the eagerness on part of the students to get started
with their coveted projects after their 'ordeal' of doing RoR for the past
week. I clarified the raison d'être of RoR being part and parcel of the course and
how RSpec is a logical extension of that initiative.

# RSpec - What's in a name?

* What does RSpec stand for? Why is it not called QSpec or YSpec?
* How does RSpect relate to the various testing categories(unit,
  integration, system, acceptance test)
* The differences of the various categories were exemplified by means of a
  ball pen manufacturer that needs to manufacture these items according to
  a variety of specifications and how the nature of testing would vary accordingly.
* Software development processes were introduced and discussed:
  TDD - BDD - DDD in order to relate RSpec accordingly.

During the enumeration of these different concepts, I made it a point to
contrast the idealistic academic nature of these with the practical nature
found in the wild. In summary, life is a jungle of chaos.

# RSpec and Rails
Incorporate `RSpec` as denoted over
[here](https://github.com/rspec/rspec-rails).

Running `rspec --init` will create:
* `.rspec`
* `spec/rails_helper` or `spec/spec_helper`, depending on version `rspec`

`.rspec` allows us to add a variety of commandline options that we would
like to run by default. Here is a sample:
```
--color
--require spec_helper
```

The first option ensures that it will display the output in color whereas
the second option ensures it will require `spec_helper.rb` for every file we
create under `spec/` folder.

We can then simply run `rspec` in the command line and it will run all
accordingly.
[Here](https://relishapp.com/rspec/rspec-core/docs/command-line) is a link
for more options to explore!

I provided a basic code example on github to satiate your appetite for more
over [here](https://github.com/Ajwah/w8d1).

# RSpec - basic syntax and fundamentals

Once the students have had the big picture of where/what is RSpec, I delved
in the specifics:

* `describe`: Pertains to describing the functionality under consideration.
  For unit testing, this would be class/instance methods which we allude to
  by nesting the keyword `describe`.
* `context`: Pertains to a specific state under which the above described
  functionality is to behave. As such, it is generally nested as different
  cases under `describe`
* `it`: Pertains to coining the expectation of our test
* `let`: Pertains to declaring values as variables that we can use
  throughout our test suite. They are laizily loaded as the `it`-clauses
  refer to them.
* `subject`: Is a specific case of `let` that abstracts away from the specific class that we are
  testing in a consistent way. This convention is helpful to quickly
  understand what is being tested vs what are mere dependencies leveraged
  to realize the test objectives.
* `before`: Pertains to introducing a certain state to our test suite.
  The `each` variant will reload that same state for `each` test whereas
  the `all` variant will load it once for `all` the tests under
  consideration.
* `after`: Used to clean up/tear down test suite state after it is over. It
  also has the two variants: `:each` and `:all`.

It is important to note that `before` and `after` `blocks` should be setup
such that we can run our tests in randomized order.

Here are concrete examples of these building `blocks`:

```ruby
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
```

All of the building blocks illustrated above are in actual fact `ruby
blocks`. You can acquaint yourself with the syntax [here](https://mixandgo.com/learn/mastering-ruby-blocks-in-less-than-5-minutes).

However, it is better practice to nest `describe` in order to specify the
`methods` under consideration:

```ruby
Rspec.describe Auction do
  let(:auctioneer) = { Auctioneer.new }
  let(:clerk) = { Clerk.new }
  let(:bidders) = { [Bidder.new] }

  subject do
    # kindly take note that this is a fictitious example that does not correspond with the current code base as `Auction` model has different attributes over here
    described_class.new(auction: @auctioneer, clerk: @clerk, bidders: @bidders)
  end

  before do
    described_class.load_inventory
  end

  describe '#inventory' do
    context 'For `Clerk`s' do
      it 'is all' do
        ...
      end
    end

    context 'For `Bidder`s' do
      it 'is a subset as what has already been sold is excluded' do
      end
    end
  end

  describe '....' do
    it '....' do
    end
  end
end
```

Above we first `describe` `Auction` as the main `class` under discussion
followed by nesting a `describe` of the instance method name of
`#inventory`. In this example, we also provided a practical example of
`context`, how it allows us to segment the various case scenarios that may
occur under a specific method depending on circumstances.

# Matchers
We went over the various matchers that RSpec provide to us:

* Identity matchers
* Comparison Matchers
* Class/Type Matchers
* True/False Matchers

# BDD: RSpec vs Cucumber
Cucumber is a collaboration framework that [erroneously](https://cucumber.io/blog/the-worlds-most-misunderstood-collaboration-tool/) has been regarded as
a testing framework. It allows us to write `feature specs` in collaboration with
`business` in order to minimize the chance of misunderstanding as well as
formerly document the main business logic/behaviour that our application is
to exhibit. Such formalization allows us to rewrite the application when
the need arises. Cucumber feature specs are written with a typical -
`Given` - `When` - `Then` syntax as follows:

```cucumber
Feature: Trade reconciliation
  Scenario: Trade logged against the wrong account
     Given a trade logged on Mike's account
     But the clearing house recorded it as Kim's trade
     When the clearing house EOD report is reconciled against fills
     Then the trade should be flagged as inconsistent
```

Such documentation is parsed by `Gherkin` and applied to the underlying
`Cucumber` steps that developers will create to implement the various tests.

As discussed before, `RSpec` pertains to a specific form of `TDD`, e.g.
`BDD` and `RSpec` provides the same notions, where:

* `describe` corresponds to `Given`
* `context` corresponds to `When`
* `it` corresponds to `Then`
