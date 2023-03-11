namespace :users do
  desc "Create Bulk users"
  task load: :environment do
    users = 10000.times.map do |t|
      name = SecureRandom.hex(7)
      {
        username: name, email: "#{name}@test.com",
        created_at: Time.now, updated_at: Time.now
      }
    end
    puts Benchmark.measure { User.upsert_all(users) }
  end
end
