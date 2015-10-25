require 'rails_helper'

describe EventsHelper do
  describe "school_name" do
    it "should fail if called on a non-class" do
      event = FactoryGirl.create(:event, has_class: false)
      expect { helper.school_name(event) }.to raise_error
    end
    context "when there is no organiser" do
      before(:each) do
        @class = FactoryGirl.create(:class, class_organiser: nil)
      end
      it "should return an empty string" do
        expect(helper.school_name(@class)).to be_nil
      end
    end
    context "when there is a class organiser" do
      before(:each) do
        @organiser = FactoryGirl.create(:organiser)
        @class = FactoryGirl.create(:class, class_organiser: @organiser)
      end
      it "should raise an error if the organiser's name is blank" do
        @organiser.name = nil
        expect { helper.school_name(@class) }.to raise_error
      end
      it "should use the name if the shortname doesn't exist" do
        @organiser.name = "foo"
        @organiser.shortname = nil
        expect(helper.school_name(@class)).to eq("foo")
      end
      it "should use the shortname as an abbreviation if it exists" do
        @organiser.name = "foo"
        @organiser.shortname = "bar"
        expect(helper.school_name(@class)).to eq(%(<abbr title="foo">bar</abbr>))
      end
    end
  end


  describe "social_link" do
    before do
      @event = double(
        id: rand(1..9999),
        url: Faker::Internet.http_url,
        title: Faker::Company.name,
        venue_name: Faker::Company.name,
        venue_area: Faker::Address.street_name,
      )
      allow(@event).to receive(:new?)
      allow(@event).to receive(:less_frequent?)
    end

    it 'renders a link' do
      expect(helper.social_link(@event)).to eq %(<a href="#{@event.url}" id="#{@event.id}">#{@event.title} - <span class="info">#{@event.venue_name} in #{@event.venue_area}</span></a>)
    end

    it "displays a label when the event is new" do
      allow(@event).to receive(:new?).and_return true
      expect(helper.social_link(@event)).to include %(<strong class="new_label">New!</strong>)
    end

    it "Adds a class to the title when the event is infrequent" do
      allow(@event).to receive(:less_frequent?).and_return true
      expect(helper.social_link(@event)).to include %(<span class="social_highlight">#{@event.title}</span>)
    end

    it "BUG: doesn't render a link when there is no url (SHOULD render a span with ID)" do
      @event = double(
        id: rand(1..9999),
        url: nil,
        title: Faker::Company.name,
        venue_name: Faker::Company.name,
        venue_area: Faker::Address.street_name,
      )
      allow(@event).to receive(:new?)
      allow(@event).to receive(:less_frequent?)
      expect(helper.social_link(@event)).to eq %(#{@event.title} - <span class="info">#{@event.venue_name} in #{@event.venue_area}</span>)
    end
  end
end

