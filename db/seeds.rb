# Idempotent seeds — safe to run multiple times
puts "Seeding..."

# ── Quest Givers (older adults posting help requests) ───────────────────────
givers = [
  { first_name: "Haruko",  last_name: "Tanaka",   username: "haruko_t",  email: "haruko@example.com",  date_of_birth: "1948-05-12", bio: "Retired teacher living in Nakameguro. Love gardening and cooking." },
  { first_name: "Kenji",   last_name: "Yamamoto",  username: "kenji_y",   email: "kenji@example.com",   date_of_birth: "1943-11-03", bio: "Former engineer. Enjoy chess and walks in the park." },
  { first_name: "Fumiko",  last_name: "Ito",       username: "fumiko_i",  email: "fumiko@example.com",  date_of_birth: "1951-07-22", bio: "Grandmother of four. Appreciate help with technology." },
]

giver_records = givers.map do |attrs|
  User.find_or_create_by!(email: attrs[:email]) do |u|
    u.assign_attributes(attrs.merge(role: :quest_giver, password: "password123"))
  end
end

# ── Quest Accepters (younger community members) ──────────────────────────────
accepters = [
  { first_name: "Ren",    last_name: "Kobayashi", username: "ren_k",    email: "ren@example.com",    date_of_birth: "1999-03-18", bio: "University student. Happy to help neighbours out." },
  { first_name: "Yui",    last_name: "Nakamura",  username: "yui_n",    email: "yui@example.com",    date_of_birth: "2001-09-05", bio: "Part-time barista, full-time community helper." },
  { first_name: "Daiki",  last_name: "Suzuki",    username: "daiki_s",  email: "daiki@example.com",  date_of_birth: "1997-12-30", bio: "Freelance designer with time to spare on weekends." },
]

accepter_records = accepters.map do |attrs|
  User.find_or_create_by!(email: attrs[:email]) do |u|
    u.assign_attributes(attrs.merge(role: :quest_accepter, password: "password123"))
  end
end

# ── Quests ───────────────────────────────────────────────────────────────────
quest_data = [
  {
    quest_giver: giver_records[0],
    title: "Help carry groceries from the supermarket",
    description: "I do my weekly shop at the Peacock on Monday mornings but struggle with the heavy bags. Would love someone to walk with me and help carry things home.",
    category: "groceries",
    location: "Nakameguro, Tokyo",
    reward: 1500,
    experience: 50,
    due_date: 2.weeks.from_now,
    status: "open"
  },
  {
    quest_giver: giver_records[0],
    title: "Trim the hedges in my small garden",
    description: "My garden hedges have gotten a bit overgrown. Tools are provided. Should take about an hour.",
    category: "gardening",
    location: "Nakameguro, Tokyo",
    reward: 2000,
    experience: 75,
    due_date: 1.week.from_now,
    status: "open"
  },
  {
    quest_giver: giver_records[1],
    title: "Set up a new smartphone",
    description: "Just got a new Android phone and need help transferring contacts, photos, and installing a few apps. Patient helper preferred!",
    category: "tech_help",
    location: "Meguro, Tokyo",
    reward: 2500,
    experience: 100,
    due_date: 3.days.from_now,
    status: "in_progress",
    quest_accepter: accepter_records[0]
  },
  {
    quest_giver: giver_records[1],
    title: "Accompany me to a hospital appointment",
    description: "I have a check-up at Meguro Central Hospital next week and would feel more comfortable with company. Trip takes about 2 hours total.",
    category: "transport",
    location: "Meguro, Tokyo",
    reward: 3000,
    experience: 120,
    due_date: 1.week.from_now,
    status: "open"
  },
  {
    quest_giver: giver_records[2],
    title: "Replace a light bulb and check smoke detectors",
    description: "A ceiling bulb in my hallway needs replacing (ladder required) and I'd like someone to test my smoke detectors while they're at it.",
    category: "household",
    location: "Shibuya, Tokyo",
    reward: 1000,
    experience: 40,
    due_date: 5.days.from_now,
    status: "completed",
    quest_accepter: accepter_records[1]
  },
  {
    quest_giver: giver_records[2],
    title: "Help me video call my grandchildren in Osaka",
    description: "I'd like to set up a regular video call routine with my family. Need help downloading an app and making a test call.",
    category: "tech_help",
    location: "Shibuya, Tokyo",
    reward: 1500,
    experience: 60,
    due_date: 4.days.from_now,
    status: "open"
  },
]

quest_records = quest_data.map do |attrs|
  Quest.find_or_create_by!(title: attrs[:title], quest_giver: attrs[:quest_giver]) do |q|
    q.assign_attributes(attrs)
  end
end

# ── Reviews (only for completed quests) ─────────────────────────────────────
completed_quest = quest_records.find { |q| q.status == "completed" }

if completed_quest && completed_quest.quest_accepter
  Review.find_or_create_by!(quest: completed_quest, reviewer: completed_quest.quest_giver) do |r|
    r.reviewee = completed_quest.quest_accepter
    r.rating = 5
    r.comment = "Yui was wonderful — punctual, cheerful, and got everything sorted in no time. Highly recommend!"
  end

  Review.find_or_create_by!(quest: completed_quest, reviewer: completed_quest.quest_accepter) do |r|
    r.reviewee = completed_quest.quest_giver
    r.rating = 5
    r.comment = "Fumiko-san was very kind and welcoming. A pleasure to help."
  end
end

puts "Done! #{User.count} users, #{Quest.count} quests, #{Review.count} reviews."
