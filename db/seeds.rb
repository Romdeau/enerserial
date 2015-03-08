# Seeds file can be used to populate any part of the database, however i would recommend importing via the import/export method for actual serial number items

#make sure you exclude the file in your .gitignore file to prevent uploading your user lists to public git repositorys

user = User.create! email: 'user.email@email.com', password: 'password', password_confirmation: 'password', admin: true, role: 'Management'
