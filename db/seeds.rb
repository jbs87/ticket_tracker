unless User.exists?(email: "admin@test.com")
  User.create(email: "admin@test.com", password: "password", admin: "true")
end

unless User.exists?(email: "viewer@test.com")
  User.create(email: "viewer@test.com", password: "password")
end

["Sublime Text 4","Opera"].each do |name|
  unless Project.exists?(name: name)
    Project.create(name: name, description: "A sample description of #{name}")
  end
end