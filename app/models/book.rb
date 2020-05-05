class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	validates :title, :body, presence: true
	validates :body, length: {maximum:200}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def favorites_count
		favorites.count.to_s
	end

end
