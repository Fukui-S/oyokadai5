class SearchController < ApplicationController

  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @value)
  end

  private
  # 完全一致
  # モデル名.where("カラム　LIKE ?","値")
  def match(model, value)
    if model == 'user'
      User.where(name: value)
    elsif model == 'book'
      Book.where(title: value)
    end
  end
  # 前方一致
  # モデル名.where("カラム LIKE ?","値%")
  def forward(model, value)
    if model == 'User'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{value}%")
    end
  end
  # 後方一致
  # モデル名.where("カラム LIKE ?","%値")
  def backward(model, value)
    if model == 'User'
      User.where("name LIKE ?", "%#{value}")
    elsif mode == 'book'
      Book.where("title LIKE ?", "%#{value}")
    end
  end

  def search_for(how, model, value)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end
end