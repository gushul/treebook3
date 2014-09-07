class Document < ActiveRecord::Base
<<<<<<< HEAD
	has_attached_file :attachment 
	validates_attachment_content_type :attachment, :content_type => /\Aimage/
	validates_attachment_file_name :attachment, :matches => [/png\Z/, /jpe?g\Z/]
=======
	has_attached_file :attachment , :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
>>>>>>> 7fe1ced5696fb78dc7b10b409f8ad56f5b7546f1
end
