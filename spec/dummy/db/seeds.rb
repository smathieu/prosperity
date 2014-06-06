1000.times do |i|
  t = (1.year.ago + rand(1.year.to_i))
  User.create name: "User #{i}", 
    email: "user+#{i}@example.org",
    created_at: t,
    updated_at: t, 
    value: (rand * 100).to_i

end

10000.times do |i|
  amount = rand(10_000)
  date = Time.now - 1.year.to_i * (rand ** 3)
  Transaction.create date: date, amount_in_cents: amount
end

# Add noise
1000.times do |i|
  amount = rand(1_000_000)
  date = (1.year.ago + rand(1.year.to_i))
  Transaction.create date: date, amount_in_cents: amount
end
