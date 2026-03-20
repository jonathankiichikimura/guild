# Clean slate before seeding
puts "Cleaning database..."
Review.destroy_all
QuestApplication.destroy_all
Quest.destroy_all
Accepter.destroy_all
Giver.destroy_all

puts "Seeding..."

# ── Givers (older adults posting help requests) ──────────────────────────────
giver_records = [
  { email: "giver1@guild.com",  first_name: "Haruko",  suburb: "meguro",    emergency_contact_name: "Keiko Tanaka",      emergency_contact_phone: "090-1234-5678" },
  { email: "giver2@guild.com",  first_name: "Kenji",   suburb: "meguro",    emergency_contact_name: "Hiroshi Yamamoto",  emergency_contact_phone: "090-2345-6789" },
  { email: "giver3@guild.com",  first_name: "Fumiko",  suburb: "shibuya",   emergency_contact_name: "Taro Ito",          emergency_contact_phone: "090-3456-7890" },
  { email: "giver4@guild.com",  first_name: "Yoshiko", suburb: "shinjuku",  emergency_contact_name: "Akira Yoshida",     emergency_contact_phone: "090-4567-8901" },
  { email: "giver5@guild.com",  first_name: "Masao",   suburb: "setagaya",  emergency_contact_name: "Yoko Sasaki",       emergency_contact_phone: "090-5678-9012" },
  { email: "giver6@guild.com",  first_name: "Kimiko",  suburb: "nerima",    emergency_contact_name: "Jun Kimura",        emergency_contact_phone: "090-6789-0123" },
  { email: "giver7@guild.com",  first_name: "Saburo",  suburb: "suginami",  emergency_contact_name: "Mika Hayashi",      emergency_contact_phone: "090-7890-1234" },
  { email: "giver8@guild.com",  first_name: "Noriko",  suburb: "setagaya",  emergency_contact_name: "Ryo Inoue",         emergency_contact_phone: "090-8901-2345" },
  { email: "giver9@guild.com",  first_name: "Takeshi", suburb: "minato",    emergency_contact_name: "Saki Abe",          emergency_contact_phone: "090-9012-3456" },
  { email: "giver10@guild.com", first_name: "Hisako",  suburb: "setagaya",  emergency_contact_name: "Naoto Fujiwara",    emergency_contact_phone: "090-0123-4567" }
].map do |attrs|
  Giver.find_or_create_by!(email: attrs[:email]) do |g|
    g.assign_attributes(attrs.merge(password: "password123"))
  end
end

# ── Accepters (younger community members) ────────────────────────────────────
accepter_records = [
  { email: "accepter1@guild.com",  full_name: "Ren Kobayashi",   suburb: "meguro",    trust_tier: "new",     quests_completed: 0 },
  { email: "accepter2@guild.com",  full_name: "Yui Nakamura",    suburb: "shibuya",   trust_tier: "trusted", quests_completed: 4 },
  { email: "accepter3@guild.com",  full_name: "Daiki Suzuki",    suburb: "shinjuku",  trust_tier: "new",     quests_completed: 1 },
  { email: "accepter4@guild.com",  full_name: "Aoi Watanabe",    suburb: "setagaya",  trust_tier: "trusted", quests_completed: 6 },
  { email: "accepter5@guild.com",  full_name: "Sora Inoue",      suburb: "nerima",    trust_tier: "new",     quests_completed: 0 },
  { email: "accepter6@guild.com",  full_name: "Hana Kato",       suburb: "suginami",  trust_tier: "veteran", quests_completed: 12 },
  { email: "accepter7@guild.com",  full_name: "Riku Hayashi",    suburb: "minato",    trust_tier: "trusted", quests_completed: 3 },
  { email: "accepter8@guild.com",  full_name: "Nana Yamada",     suburb: "meguro",    trust_tier: "new",     quests_completed: 2 },
  { email: "accepter9@guild.com",  full_name: "Kai Matsumoto",   suburb: "shibuya",   trust_tier: "veteran", quests_completed: 9 },
  { email: "accepter10@guild.com", full_name: "Mia Tanaka",      suburb: "shinjuku",  trust_tier: "trusted", quests_completed: 5 }
].map do |attrs|
  Accepter.find_or_create_by!(email: attrs[:email]) do |a|
    a.assign_attributes(attrs.merge(password: "password123"))
  end
end

# ── Quests ────────────────────────────────────────────────────────────────────
quest_data = [
  {
    giver: giver_records[0],
    title: "Help carry groceries from the supermarket",
    description: "I do my weekly shop at the Peacock on Monday mornings but struggle with the heavy bags. Would love someone to walk with me and help carry things home.",
    category: "groceries",
    suburb: "meguro",
    reward_amount: 1500,
    reward_type: "yen",
    expires_at: 2.weeks.from_now,
    status: "open"
  },
  {
    giver: giver_records[0],
    title: "Trim the hedges in my small garden",
    description: "My garden hedges have gotten a bit overgrown. Tools are provided. Should take about an hour.",
    category: "gardening",
    suburb: "meguro",
    reward_amount: 2000,
    reward_type: "yen",
    expires_at: 1.week.from_now,
    status: "open"
  },
  {
    giver: giver_records[1],
    title: "Set up a new smartphone",
    description: "Just got a new Android phone and need help transferring contacts, photos, and installing a few apps. Patient helper preferred!",
    category: "tech_help",
    suburb: "meguro",
    reward_amount: 2500,
    reward_type: "yen",
    expires_at: 3.days.from_now,
    status: "in_progress",
    accepter: accepter_records[0]
  },
  {
    giver: giver_records[1],
    title: "Accompany me to a hospital appointment",
    description: "I have a check-up at Meguro Central Hospital next week and would feel more comfortable with company. Trip takes about 2 hours total.",
    category: "transport",
    suburb: "meguro",
    reward_amount: 3000,
    reward_type: "yen",
    expires_at: 1.week.from_now,
    status: "open"
  },
  {
    giver: giver_records[2],
    title: "Replace a light bulb and check smoke detectors",
    description: "A ceiling bulb in my hallway needs replacing (ladder required) and I'd like someone to test my smoke detectors while they're at it.",
    category: "household",
    suburb: "shibuya",
    reward_amount: 1000,
    reward_type: "yen",
    expires_at: 5.days.from_now,
    status: "completed",
    accepter: accepter_records[1]
  },
  {
    giver: giver_records[2],
    title: "Help me video call my grandchildren in Osaka",
    description: "I'd like to set up a regular video call routine with my family. Need help downloading an app and making a test call.",
    category: "tech_help",
    suburb: "shibuya",
    reward_amount: 1500,
    reward_type: "yen",
    expires_at: 4.days.from_now,
    status: "open"
  },
  {
    giver: giver_records[3],
    title: "Water my plants while I visit family",
    description: "Going to Kyoto for 5 days. I have about 12 indoor plants that need watering every other day. Key will be left with the building manager.",
    category: "household", suburb: "shinjuku", reward_amount: 2000, reward_type: "yen",
    expires_at: 10.days.from_now, status: "open"
  },
  {
    giver: giver_records[4],
    title: "Help me sort through old photographs",
    description: "I have boxes of old photos I'd like help organising and scanning. Good company welcome too!",
    category: "other", suburb: "setagaya", reward_amount: 1800, reward_type: "yen",
    expires_at: 2.weeks.from_now, status: "open"
  },
  {
    giver: giver_records[5],
    title: "Assemble a flat-pack bookshelf",
    description: "Bought a new bookshelf from IKEA but assembling furniture on my own is difficult. Tools available at home.",
    category: "household", suburb: "nerima", reward_amount: 2500, reward_type: "yen",
    expires_at: 1.week.from_now, status: "open"
  },
  {
    giver: giver_records[6],
    title: "Walk my dog on Saturday morning",
    description: "My usual walker is away this Saturday. Hana is a friendly shiba inu, about 30 minutes around the local park is all she needs.",
    category: "other", suburb: "suginami", reward_amount: 1200, reward_type: "yen",
    expires_at: 6.days.from_now, status: "open"
  },
  {
    giver: giver_records[7],
    title: "Help install a printer and test it works",
    description: "New printer arrived but I cannot get it connected to my laptop. Would need someone patient with older technology.",
    category: "tech_help", suburb: "setagaya", reward_amount: 2000, reward_type: "yen",
    expires_at: 5.days.from_now, status: "in_progress", accepter: accepter_records[3]
  },
  {
    giver: giver_records[8],
    title: "Pick up a prescription from the pharmacy",
    description: "My prescription is ready at the Aoyama pharmacy but I'm not well enough to go myself. It's a 10-minute walk from Omotesando station.",
    category: "transport", suburb: "minato", reward_amount: 1000, reward_type: "yen",
    expires_at: 2.days.from_now, status: "open"
  }
]

quest_records = quest_data.map do |attrs|
  Quest.find_or_create_by!(title: attrs[:title], giver: attrs[:giver]) do |q|
    q.assign_attributes(attrs)
  end
end

# ── Reviews (only for completed quests) ──────────────────────────────────────
completed_quest = quest_records.find { |q| q.status == "completed" }

if completed_quest&.accepter && Review.where(quest: completed_quest).none?
  Review.create!(
    quest: completed_quest,
    giver: completed_quest.giver,
    accepter: completed_quest.accepter,
    rating: 5,
    comment: "Yui was wonderful — punctual, cheerful, and got everything sorted in no time. Highly recommend!"
  )
end

puts "Done! #{Giver.count} givers, #{Accepter.count} accepters, #{Quest.count} quests, #{Review.count} reviews."
