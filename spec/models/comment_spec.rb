require 'rails_helper'
# require 'test_helper'

RSpec.describe Comment, type: :model do

  before(:each) do
    User.destroy_all
  end

  it "can be marked declined" do
    make_a_trade
    # Decline offer
    @comment1.set_declined

    # Reload from database to updates from database
    @barter.reload
    expect(@barter.comments.select{ |comment| comment.accept == false }.first.comment).to eq "1st comment"
    expect(@barter.comments.select{ |comment| comment.accept.nil? }.first.comment).to eq "2nd comment"
  end

  it "can be marked accepted, thus making all other comments for the barter at hand declined" do
    make_a_trade
    # accept offer
    @comment1.set_accepted

    # Reload from database to updates from database
    @barter.reload
    expect(@barter.comments.select{ |comment| comment.accept == true }.first.comment).to eq "1st comment"
    expect(@barter.comments.select{ |comment| comment.accept == false }.first.comment).to eq "2nd comment"
  end

  def make_a_trade
    # create new user
    @owner_user = User.new
    @owner_user.email = "owner@dom.com"
    @owner_user.save
    # create new barter
    @barter = Barter.new
    @barter.user = @owner_user
    @barter.description = "yummy apples"
    @barter.category = "goods"
    @barter.expiration = Date.tomorrow
    @barter.product = "apple"
    @barter.neighborhood = "hillcrest"
    @barter.interested_in = "bananas"
    # check that @barter saves to db
    # @barter.save
    # puts @barter.errors.full_messages
    expect(@barter.save).to eq true

    # check that @barter's owner is @owner_user
    expect(@barter.user).to eq @owner_user
    # create new user to create new comment.
    @comment_user = User.new
    @comment_user.email = "comment@me.com"
    @comment_user.save
    # created comment true (accepted)
    @comment1 = Comment.new
    # linking user to comments in db
    @comment1.user = @comment_user
    # linking comment to barter
    @comment1.barter = @barter
    @comment1.comment = "1st comment"
    expect(@comment1.save).to eq true
    # check that @comment1 user is @comment_user
    expect(@comment1.user).to eq @comment_user
    @comment2 = Comment.new
    @comment2.user = @comment_user
    @comment2.barter = @barter
    @comment2.comment = "2nd comment"
    @comment2.save
    expect(@comment1.accept).to be_nil
    expect(@comment2.accept).to be_nil
    # check that all @barters comments have accept = to nil
    @barter.comments.each do |comment|
      expect(comment.accept).to be_nil
    end
    # check how many comments the barter has.
    expect(@barter.comments.count).to eq 2
  end
end
