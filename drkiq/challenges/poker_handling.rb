require 'byebug'
require 'json'
class PokerHandling
    attr_reader :table_cards, :player_cards, :players_number, :deck
    
    @@suites = ["hearts", "spades", "diamonds", "clovers"]

    @@card_values = {
        2 => 2 , 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 
        8 => 8, 9 => 9, 10 => 10, 
        12 => "J", 13 => "Q", 14 => "K", 15 => "A", 
    }

    def initialize(players_number:)
        @hand_cards = {}
        @players_number = players_number
        @table_cards = {}
        @deck = []
        generate_deck
        generate_table_cards
        set_winner_of table_results
    end

    def generate_deck
        @@card_values.each do |index, card_value|
            @@suites.each do |suite|
                card = {}
                card[suite.to_sym] = index.to_i
                @deck << card
            end
        end
    end

    def generate_player_cards
        @deck.shuffle!.slice!(0, 5)
    end

    def generate_table_cards()
        i = 1
        begin
            @table_cards["player:#{i}"]  = generate_player_cards
            i +=1
        end while i <= @players_number
    end

    # def generate_table_cards()
    #     i = 0
    #     begin
    #         @table_cards << generate_player_cards
    #         i +=1
    #     end while i < @players_number
    # end

    def table_results
        # byebug
        results  = {}
        @table_cards.each do |player_index, player_cards|
            results[player_index.to_s] = analyze player_cards
        end
        results
    end

    def set_winner_of results
        # min winning_value are best
        winning_value = results.values.min_by { |player_report, player_index| player_report[:winning_value]}[:winning_value]
        winners = results.select do |index, value| 
            value if value[:winning_value] == winning_value
        end
        settle_duplicate_of winners
    end

    def settle_duplicate_of winners
        puts "We have duplicate winners #{winners.count}" if winners.count > 1
        
        group_best_cards = winners.map do 
            |k, v| {k => v[:analyzed][:kind_group].key(v[:analyzed][:kind_group].values.max) } 
        end
        winner = group_best_cards.max_by do |v, l| v.values.first end
        # byebug
        puts "winner is #{winner.keys.first}"
    end

    def analyze(player_cards)
        hand = group_cards_of hand: player_cards
        hand[:cards] = player_cards
        # min index set as best_score
        win_mapping = set_win_mapping(hand)
        best_score = win_mapping.detect do |key, value| value end
        # byebug
        {
            :analyzed => hand,
            :best_score => best_score,
            :winning_value => win_mapping.keys.index(best_score.first)
        }
    end

    private

    def group_cards_of(hand:)
        raise "Invalid player cards" if (hand.empty? || hand.count != 5)
        hand.inject({:suite_group => {}, :kind_group => {}}) do |collector, card|
            collector[:suite_group][card.keys.first] = collector[:suite_group][card.keys.first].to_i + 1
            collector[:kind_group][card.values.first.to_s] = collector[:kind_group][card.values.first.to_s].to_i + 1
            collector
        end
    end

    def set_win_mapping(hand)
        {
            :has_royal => has_royal?(hand),
            :straigth_flush => has_straight_flush?(hand),
            :four_of_a_kind => has_four_of_a_kind?(hand),
            :full_house => has_full_house?(hand),
            :flush => has_flush?(hand),
            :straight => has_straight?(hand),
            :three_of_a_kind => has_three_of_a_kind?(hand),
            :two_pairs => has_two_pairs?(hand),
            :one_pair => has_one_pair?(hand),
            :max_card => true   
        }
    end

    def has_flush? hand
        hand[:suite_group].count == 1
    end

    def has_straight? hand
        card_values = hand[:cards].collect do |v| v.values.first end
        card_values.sum == do_consecutive_sum(card_values.min, card_values.max)
    end

    def has_straight_flush? hand
        has_flush?(hand) && has_straight?(hand)
    end

    def has_royal? hand
        has_straight_flush?(hand) && hand[:suite_group].has_key?(:clovers)
    end

    def has_four_of_a_kind? hand
        hand[:kind_group].values.include? 4
    end

    def has_one_pair? hand
        get_pairs_of(hand).count == 1
    end

    def has_two_pairs? hand
        get_pairs_of(hand).count == 2
    end

    def has_three_of_a_kind? hand
        get_three_of(hand).count == 1
    end

    def has_full_house? hand
        has_three_of_a_kind?(hand) && has_one_pair?(hand)
    end

    def get_pairs_of hand
        hand[:kind_group].select do |index, value| value == 2 end
    end

    def get_three_of hand
        hand[:kind_group].select do |index, value| value == 3 end
    end

    def do_consecutive_sum(min, max)
        (max*(max+1))/2 - (min*(min-1))/2
    end

end

poker_handling = PokerHandling.new(players_number: 5)
# puts poker_handling.deck.count
# poker_handling.generate_table_cards
puts "rendering table cards"
poker_handling.table_results.each do |result|
    puts result.to_json
end
# puts poker_handling.set_winner_of poker_handling.table_results
# puts poker_handling.tab
# puts poker_handling.combo_report_of player_cards: poker_handling.table_cards.first
# arr.inject({}) do |sum, val| 
#     sum[val[:fruit]] = sum[val[:fruit]].to_i + 1 
#     sum 
# end
# t.inject({"suites" => {}}) do |acc, card| 
#     acc["suites"][card.keys.first] = acc["suites"][card.keys.first].to_i + 1 
#     acc 
# end