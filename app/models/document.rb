class Document < ActiveRecord::Base
	has_attached_file :attachment
	validates_attachment_content_type :attachment, :content_type => /\Aimage/
	validates_attachment_file_name :attachment, :matches => [/png\Z/, /jpe?g\Z/]
end
