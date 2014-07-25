["brick_1.jpg", "brick_2.jpg"].each do |n|
  file = File.open("brick_1.jpg").read
  count = 2
  15.times do |i|
    File.open("#{n.split(".").first}_#{count}.jpg", "w+") do |f|
      f.puts file
    end
    count += 1
  end
end