require 'spec_helper'

describe "Creating a new review" do

  let!(:valid_movie) { FactoryGirl.create(:movie) }
    
  it "creates a new review when all required fields are filled in" do
    visit movie_path(valid_movie)
    prev_count = Review.count

    click_on "Add a Review"
    fill_in :title, with: "This was an awesome movie"
    fill_in :body, with: "The guy is totally made of metal!"

    click_on "Submit"

    expect(Review.count).to eql(prev_count + 1)
    expect(page).to have_content(valid_movie.title)
    expect(page).to have_content("This is an awesome movie")

  end

end