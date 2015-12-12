require "rails_helper"

RSpec.feature "showing an Article" do
	
	before do 
		@kkk = User.create!(email: "kkk@kkk.com", password: "kkkkkkkk")
		@ppp = User.create!(email: "ppp@ppp.com", password: "pppppppp")

		@article = Article.create(title: "The first article", body: "body of first article", user: @kkk)
	end

	scenario "A non-signed in user doesn't see edit and delete" do
		visit "/"
		click_link @article.title
		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))

		expect(page).not_to have_link("Edit Article")
		expect(page).not_to have_link("Delete Article")

	end

	scenario "A non-owner signed-in user can't see edit and delete button" do
		login_as(@ppp)
		visit "/"
		click_link @article.title


		expect(page).not_to have_link("Edit Article")
		expect(page).not_to have_link("Delete Article")

	end

	scenario "A signed-in user can see edit and delete button" do
		login_as(@kkk)
		visit "/"
		click_link @article.title


		expect(page).to have_link("Edit Article")
		expect(page).to have_link("Delete Article")

	end

	scenario "Display individual article" do
		visit "/"

		click_link @article.title
		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))
	end
end 