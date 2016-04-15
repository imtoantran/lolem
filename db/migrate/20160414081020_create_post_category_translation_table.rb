class CreatePostCategoryTranslationTable < ActiveRecord::Migration
  def up
    PostCategory.create_translation_table! name: :string, permalink: :string, description: :text
    PostCategory.all.each do |pc|
      l = pc.translations.new
      l.locale = 'vi'
      l.name = pc.name
      l.permalink = pc.permalink
      l.description = pc.description
      l.save!
    end
  end
  def down
    PostCategory.drop_translation_table!
  end
end
