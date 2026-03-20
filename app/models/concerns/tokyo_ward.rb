module TokyoWard
  WARDS = %w[Adachi Arakawa Bunkyo Chiyoda Chuo Edogawa Itabashi Katsushika Kita Koto
             Meguro Minato Nakano Nerima Ota Setagaya Shibuya Shinagawa Shinjuku
             Suginami Sumida Taito Toshima].freeze

  WARD_ENUM = WARDS.index_by { |w| w.downcase.to_sym }.freeze

  extend ActiveSupport::Concern

  included do
    enum :suburb, TokyoWard::WARD_ENUM
  end
end
