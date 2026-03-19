# Idempotent seeds — safe to run multiple times
puts "Seeding..."

# ── Givers (older adults posting help requests) ───────────────────────────────
giver_records = [
  { first_name: "Haruko", email: "haruko@example.com", suburb: "Nakameguro" },
  { first_name: "Kenji",  email: "kenji@example.com",  suburb: "Meguro" },
  { first_name: "Fumiko", email: "fumiko@example.com", suburb: "Shibuya" },
].map do |attrs|
  Giver.find_or_create_by!(email: attrs[:email]) do |g|
    g.assign_attributes(attrs.merge(password: "password123"))
  end
end

# ── Accepters (younger community members) ─────────────────────────────────────
accepter_records = [
  { full_name: "Ren Kobayashi", email: "ren@example.com"   },
  { full_name: "Yui Nakamura",  email: "yui@example.com"   },
  { full_name: "Daiki Suzuki",  email: "daiki@example.com" },
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
    suburb: "Nakameguro",
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
    suburb: "Nakameguro",
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
    suburb: "Meguro",
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
    suburb: "Meguro",
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
    suburb: "Shibuya",
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
    suburb: "Shibuya",
    reward_amount: 1500,
    reward_type: "yen",
    expires_at: 4.days.from_now,
    status: "open"
  },
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
