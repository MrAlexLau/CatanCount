class Roll < ActiveRecord::Base
  attr_accessible :dice1, :dice2, :game_id, :total

  def self.get_roll_percentages
    # 2.7777 #percentage for 2
    # 5.5555  #percentage for 3
    # 8.3333 #percentage for 4
    # 11.1111 #percentage for 5
    # 13.8888 #percentage for 6
    # 16.6666 #percentage for 7
    # 13.8888 #percentage for 8
    # 11.1111 #percentage for 9
    # 8.3333 #percentage for 10
    # 5.5555 #percentage for 11
    # 2.7777 #percentage for 12
    roll_percentages = [2.7777, 5.5555, 8.3333, 11.1111, 13.8888, 16.6666, 13.8888, 11.1111, 8.3333, 5.5555, 2.7777]
    roll_percentages.each_with_index do |roll_percent, i|
      roll_percentages[i] = roll_percent / 100
    end
  end

  def self.get_game_stats(game_numbers)
    expected = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    actual = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    roll_percentages = Roll.get_roll_percentages
    rolls_for_games = Roll.where(game_id: game_numbers).order("created_at DESC")

    rolls_for_games.each do |roll|
      actual[roll.total - 2] += 1
    end

    total_number_of_rolls = rolls_for_games.count
    for i in 0..10
      expected[i] = (roll_percentages[i] * total_number_of_rolls).round(2)
    end


    return actual, expected
  end
end
