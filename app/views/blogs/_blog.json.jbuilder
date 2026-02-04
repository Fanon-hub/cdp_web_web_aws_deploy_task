json.extract! blog, :id, :title, :content, :thumbnail, :created_at, :updated_at
json.url blog_url(blog, format: :json)
json.thumbnail url_for(blog.thumbnail)
