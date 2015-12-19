class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :diary

  def post_date
    self.created_at.strftime("%Y年%m月%d日 %H時%M分")
  end
end
