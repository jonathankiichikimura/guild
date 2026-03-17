require "faker"

Faker::Config.locale = "ja"

puts "Cleaning database..."
Review.destroy_all
QuestAcceptance.destroy_all
Quest.destroy_all
User.destroy_all

# ---------------------------------------------------------------------------
# Users
# ---------------------------------------------------------------------------
puts "Creating users..."

PASSWORD = "password123"

15.times do
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  User.create!(
    first_name: first_name,
    last_name:  last_name,
    email:      Faker::Internet.unique.email(name: "#{first_name} #{last_name}"),
    password:   PASSWORD,
    bio:        Faker::Lorem.paragraph(sentence_count: 2)
  )
end

users = User.all.to_a

puts "  Created #{User.count} users"

# ---------------------------------------------------------------------------
# Quest content pools (domain-specific, not lorem ipsum)
# ---------------------------------------------------------------------------
QUEST_TEMPLATES = {
  "groceries" => [
    { title: "Help with weekly grocery shopping",
      description: "I need someone to accompany me to the supermarket and help carry bags. I live near the station and the round trip takes about an hour." },
    { title: "Grocery delivery from local market",
      description: "Could you pick up a short list of items from the neighbourhood market? I have difficulty walking long distances but can pay on delivery." },
    { title: "Help finding ingredients for a traditional recipe",
      description: "I want to cook a special dish for my grandchildren but need help locating specific ingredients. Should take about an hour." },
    { title: "Weekly supermarket run",
      description: "I need assistance with my weekly shopping trip. I move slowly, so a patient and kind helper would be very much appreciated." },
    { title: "Fresh produce from the morning market",
      description: "The early morning market near my home has the best vegetables, but I can no longer get there on my own. Could you escort me?" },
  ],
  "gardening" => [
    { title: "Pruning rose bushes in the backyard",
      description: "My rose bushes have grown quite wild and need a good trim. All tools are provided. The job should take about two hours." },
    { title: "Help planting spring vegetables",
      description: "I want to plant tomatoes and cucumbers in my small garden but my back is not what it used to be. Materials will be provided." },
    { title: "Raking fallen leaves in the garden",
      description: "Autumn leaves have piled up and I need help clearing them. The garden is roughly 30 square metres." },
    { title: "Weeding the flower beds",
      description: "My flower beds have become overgrown over the summer. Looking for someone happy to get their hands a little dirty." },
    { title: "Repotting houseplants",
      description: "I have about ten houseplants that need repotting into fresh soil. I have all the pots and compost ready to go." },
  ],
  "tech_help" => [
    { title: "Set up my new smartphone",
      description: "I just received a new Android phone and need help transferring contacts and photos from my old handset." },
    { title: "Teach me how to use video calls",
      description: "I would like to learn LINE video calls to keep in touch with my grandchildren overseas. About one hour of patient instruction needed." },
    { title: "Help navigating a streaming service",
      description: "My children subscribed me to a streaming service but I cannot figure out how to find programmes. A calm, patient teacher needed!" },
    { title: "Connect and test a new home printer",
      description: "A printer arrived last week and I need someone to connect it to my laptop and print a test page." },
    { title: "Recover old family photos from a USB drive",
      description: "I have a USB drive from about ten years ago full of family photos. I need help viewing them and saving copies somewhere safe." },
    { title: "Explain how to use internet banking safely",
      description: "My bank has moved everything online and I feel nervous about it. Could you sit with me and explain how to use it safely?" },
  ],
  "transport" => [
    { title: "Ride to a hospital appointment",
      description: "I have a check-up next week and need a ride to the clinic about 20 minutes away. A return trip would also be needed." },
    { title: "Lift to the community centre",
      description: "The community centre is running a calligraphy class I want to attend, but the bus is difficult. Would appreciate a friendly driver." },
    { title: "Drive to a large home goods store",
      description: "I need to buy some bulky items that will not fit on public transport. Fuel costs will be reimbursed of course." },
    { title: "Help getting to the ward office",
      description: "I need to submit some paperwork at the ward office and the journey on my own is quite stressful. Company would be wonderful." },
  ],
  "household" => [
    { title: "Help rearranging the living room furniture",
      description: "I want to rearrange my living room but the furniture is too heavy for me alone. Should take about an hour with two people." },
    { title: "Changing light bulbs in high fixtures",
      description: "Several ceiling lights have gone out and I can no longer safely climb a ladder. A quick job for someone steady on their feet!" },
    { title: "Hanging picture frames on the wall",
      description: "I have several framed photos I want to display. A drill and all fixings are available, I just need a steady hand." },
    { title: "Deep cleaning the kitchen",
      description: "Looking for help with a thorough kitchen clean — oven, refrigerator, and all cabinets. About three hours of solid work." },
    { title: "Assembling flat-pack furniture",
      description: "A new bookshelf arrived flat-packed and the instructions are very confusing. An experienced hand would be a lifesaver." },
    { title: "Organising and decluttering a spare room",
      description: "My spare room has become rather cluttered over the years. I need a helping pair of hands and a good eye for organisation." },
  ],
  "other" => [
    { title: "Teach me some basic origami",
      description: "I would love to learn a few origami designs to share with my grandchildren on their next visit. An hour or two would be plenty." },
    { title: "Walking companion at the local park",
      description: "My doctor has recommended daily walks but I feel much safer with company. Looking for a regular friendly walking companion." },
    { title: "Proofreading a short personal memoir",
      description: "I have written a short memoir for my family and would love a fresh pair of eyes before I have it printed." },
    { title: "Help at the community flea market",
      description: "I am selling some items at the local flea market on Saturday and could use an extra pair of hands to set up and pack down." },
    { title: "Reading aloud from a favourite novel",
      description: "My eyesight has been troubling me lately. I would love someone to come and read aloud from a book we can choose together." },
  ],
}.freeze

LOCATIONS = [
  "Shibuya, Tokyo", "Shinjuku, Tokyo", "Nakameguro, Tokyo", "Koenji, Tokyo",
  "Setagaya, Tokyo", "Nerima, Tokyo", "Bunkyo, Tokyo", "Meguro, Tokyo",
  "Shimokitazawa, Tokyo", "Harajuku, Tokyo",
  "Yokohama, Kanagawa", "Kamakura, Kanagawa", "Kawasaki, Kanagawa",
  "Osaka, Osaka", "Kyoto, Kyoto", "Nara, Nara", "Kobe, Hyogo",
].freeze

REWARDS = [500, 800, 1000, 1200, 1500, 2000, 2500, 3000, 3500, 5000].freeze

# ---------------------------------------------------------------------------
# Quests
# ---------------------------------------------------------------------------
puts "Creating quests..."

quest_buckets = { open: [], in_progress: [], completed: [] }

# 15 open quests
15.times do
  category = Quest::CATEGORIES.sample
  template = QUEST_TEMPLATES[category].sample
  quest_buckets[:open] << Quest.create!(
    user:        users.sample,
    title:       template[:title],
    description: template[:description],
    category:    category,
    status:      "open",
    location:    LOCATIONS.sample,
    reward:      REWARDS.sample,
    due_date:    rand(7..60).days.from_now
  )
end

# 10 in-progress quests
10.times do
  category = Quest::CATEGORIES.sample
  template = QUEST_TEMPLATES[category].sample
  quest_buckets[:in_progress] << Quest.create!(
    user:        users.sample,
    title:       template[:title],
    description: template[:description],
    category:    category,
    status:      "in_progress",
    location:    LOCATIONS.sample,
    reward:      REWARDS.sample,
    due_date:    rand(1..14).days.from_now
  )
end

# 15 completed quests
15.times do
  category = Quest::CATEGORIES.sample
  template = QUEST_TEMPLATES[category].sample
  quest_buckets[:completed] << Quest.create!(
    user:        users.sample,
    title:       template[:title],
    description: template[:description],
    category:    category,
    status:      "completed",
    location:    LOCATIONS.sample,
    reward:      REWARDS.sample,
    due_date:    rand(1..60).days.ago
  )
end

puts "  Created #{Quest.count} quests"

# ---------------------------------------------------------------------------
# Quest Acceptances
# ---------------------------------------------------------------------------
puts "Creating quest acceptances..."

quest_buckets[:in_progress].each do |quest|
  accepter = (users - [quest.user]).sample
  QuestAcceptance.create!(quest: quest, user: accepter, status: "active")
end

quest_buckets[:completed].each do |quest|
  accepter = (users - [quest.user]).sample
  QuestAcceptance.create!(quest: quest, user: accepter, status: "completed")
end

puts "  Created #{QuestAcceptance.count} quest acceptances"

# ---------------------------------------------------------------------------
# Reviews  (completed quests only — both parties may leave one)
# ---------------------------------------------------------------------------
REVIEW_COMMENTS = [
  "Very helpful and punctual. Would definitely ask again!",
  "Kind and patient. Made the whole experience easy.",
  "Did a wonderful job — highly recommended.",
  "Friendly and efficient. Exceeded my expectations.",
  "A real pleasure to work with. Thank you so much!",
  "Very thorough and careful. Really appreciated the attention to detail.",
  "Showed up on time and was wonderfully professional.",
  "Went above and beyond what was asked. Truly grateful.",
  "Reliable and cheerful. Made my day brighter!",
  "Did everything asked without any fuss. A great helper.",
  "So kind and gentle. Felt completely at ease the whole time.",
  "Excellent communication beforehand and perfect execution on the day.",
  nil, # some reviews without comments
  nil,
].freeze

puts "Creating reviews..."

quest_buckets[:completed].each do |quest|
  acceptance = quest.quest_acceptances.first
  next unless acceptance

  giver    = quest.user
  accepter = acceptance.user
  next if giver == accepter

  # Quest giver reviews the accepter
  Review.create!(
    quest:    quest,
    reviewer: giver,
    reviewee: accepter,
    rating:   rand(3..5),
    comment:  REVIEW_COMMENTS.sample
  )

  # Accepter reviews the quest giver (~70% of the time)
  next unless rand < 0.7

  Review.create!(
    quest:    quest,
    reviewer: accepter,
    reviewee: giver,
    rating:   rand(3..5),
    comment:  REVIEW_COMMENTS.sample
  )
end

puts "  Created #{Review.count} reviews"

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
puts "\nSeed complete!"
puts "  Users:             #{User.count}"
puts "  Quests:            #{Quest.count} " \
     "(#{Quest.where(status: 'open').count} open, " \
     "#{Quest.where(status: 'in_progress').count} in_progress, " \
     "#{Quest.where(status: 'completed').count} completed)"
puts "  QuestAcceptances:  #{QuestAcceptance.count}"
puts "  Reviews:           #{Review.count}"
puts "\nAll users have password: #{PASSWORD}"
puts "Sample login: #{User.first.email}"
