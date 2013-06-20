require 'spec_helper'

feature 'moderating a review', %q{
  As an administrator
  I want to be able to moderate a review
  So that I can keep shit off my site
} do

end

feature 'flaggin a review', %q{
  As a user
  I want to be able to flag a review for moderation
  So that I don't look at shit
} do

  let!(:valid_user) { FactoryGirl.create(:user) }
  let!(:movie) { FactoryGirl.create(:movie) }
  let!(:review) { FactoryGirl.create(:review, movie: movie) }

  before do
    sign_in_as valid_user
  end


  scenario 'I can click on a flag for review button next to a review' do
    flag_a_review
    expect(page).to have_content('Flag for review')
  end

  scenario 'If I flag a review, I must specify why it was flagged' do
    flag_a_review
    click_on 'Flag for review'
    expect(page).to have_content('Please explain')
  end
  scenario 'If I flag a review, it should appear on the page as under review', focus: true do
    flag_a_review
    click_on 'Flag for review'
    fill_in 'Reason', with: 'haters gonna hate'
    click_on 'Flag'
    expect(current_path).to eql(movie_reviews_path(movie))
    expect(page).to have_content('Under review')
  end

  def flag_a_review
    visit movie_path(movie)
    click_on review[:title]
  end


end
