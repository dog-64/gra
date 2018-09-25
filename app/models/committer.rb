# комиттеры в репозитории
class Committer < ApplicationRecord

  validates :repo, presence: true
  validates :user, presence: true
  validates :total, presence: true
  validates :place, presence: true
  validates :stock, presence: true

  validates :repo, uniqueness: { scope: [:user, :place] }

end
