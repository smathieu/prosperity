1000.times do |i|
  t = (1.year.ago + rand(1.year.to_i))
  User.create name: "User #{i}", 
    email: "user+#{i}@example.org",
    created_at: t,
    updated_at: t, 
    value: (rand * 100).to_i

end
