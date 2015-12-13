require "rails_helper"

RSpec.feature "Adding Reviews to Articles" do
	before do
		@john = User.create(email: "kkk@kkk.com", password: "kkkkkkkk")
		@fred = User.create(email: "ppp@ppp.com", password: "pppppppp")

		@article = Article.create(title: "the first title", body: "the first body", user: @john)
	end	

	scenario "permits a signed in user to write a reivew" do
		login_as(@fred)

		visit "/"
		click_link @article.title
		fill_in "New Comment", with: "awesome"
		click_button "Add comment"

		expect(page).to have_content("Comment has been created")
		expect(page).to have_content("awesome")
		expect(current_path).to eq(article_path(@article.comments.last.id))
	end

end