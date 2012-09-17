class Roll < ActiveRecord::Base
  attr_accessible :dice1, :dice2, :game_number, :total
  
  def self.get_game_id()
    x = Roll.maximum("game_number")
    if x.nil?
      return 1
    else
      return x + 1
    end
  end
  
  def self.get_game_stats(game_number)
    expected = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    actual = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
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
            
    rolls_for_game = Roll.where("game_number = (?)", game_number)
    
    rolls_for_game.each do |roll|
      actual[roll.total - 2] += 1
    end
    
    
    total_number_of_rolls = rolls_for_game.count
    for i in 0..10
      #debugger
      expected[i] = roll_percentages[i] * total_number_of_rolls
    end
    
    
    return actual, expected
  end
end
