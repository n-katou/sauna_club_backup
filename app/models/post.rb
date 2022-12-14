# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings # 上にスルーするtaggingsが来ないとエラーになる。イメージとしてtagとpostを直接繋いだようなイメージ

  # post = Post.new
  # post.tags　#これで紐づいたタグを簡単に持ってこれる。

  # tags = post.taggings.map {|tagging| tagging.tags }.flatten #throughを使わない場合はこうやってビューに記述しないといけない。

  has_one_attached :post_image

  validates :title, presence: true
  validates :post_content, presence: true

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      post_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpg")
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id) # これの意味もいまいちわからない
  end

  # キーワード検索
  def self.posts_search(keyword)
    Post.where(["title like? OR post_content like?", "%#{sanitize_sql_like(keyword)}%", "%#{sanitize_sql_like(keyword)}%"])
  end

  # タグ検索
  def self.tags_search(keyword)
    Post.joins(:tags).where("tags.tag_name LIKE ?", "%#{sanitize_sql_like(keyword)}%") # joinsでhas_many or has_one IDを繋げる。
  end

  # タグ選択
  def self.tags_select(id)
    Post.joins(:tags).where("tags.id = ?", id) # joinsでhas_many or has_one IDを繋げる。
  end
end
