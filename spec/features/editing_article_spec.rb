require "rails_helper"

RSpec.feature "Editing an Article" do 

	before do
		@john = User.create!(email: "kkk@kkk.com", password: "kkkkkkkk")
		login_as(@john)
		@article = Article.create(title: "First Article", body: "Body of first article", user: @john)
	end

	scenario "A user updates an article" do
		visit "/"

		click_link @article.title
		click_link "Edit Article"

		fill_in "Title", with: "Update article"
		fill_in "Body", with: "Updated body of article"

		click_button "Update Article"

		expect(page).to have_content("Article has been updated")
		expect(page.current_path).to eq(article_path(@article))
	end

	scenario "A user fails to update an article" do	

		visit "/"

		click_link @article.title
		click_link "Edit Article"

		fill_in "Title", with: ""
		fill_in "Body", with: ""

		click_button "Update Article"

		expect(page).to have_content("Article has not been updated")
		expect(page.current_path).to eq(article_path(@article))
	end
end