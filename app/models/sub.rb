# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  moderator_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, :description, presence: true

  helper_method :require_is_moderator

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User

  def is_moderator?
    self.moderator_id == current_user.id
  end

  def require_is_moderator
    redirect_to subs_url unless is_moderator?
  end

end
