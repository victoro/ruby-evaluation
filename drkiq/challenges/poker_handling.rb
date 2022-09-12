require 'byebug'
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
        @table_cards = []
        @deck = []
        generate_deck
        generate_table_cards
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
        i = 0
        begin
            @table_cards << generate_player_cards
            i +=1
        end while i < @players_number
    end

    def table_results
        # byebug
        results  = []
        @table_cards.each_with_index do |player_cards, player_index|
            # byebug
            player_report = {}
            player_report[:cards] = player_cards
            report = combo_report_of(player_cards: player_cards)
            player_report[:report] = report
            # pick only index
            player_report[:best_score] = report.detect do |key, value| value end
            # byebug
            player_report[:winning_value] = report.keys.index player_report[:best_score].first
            results[player_index] = player_report
        end
        results
    end

    def set_winner_of results
        winning_value = results.min_by { |player_report, player_index| player_report[:winning_value]}[:winning_value]
        results.select do |index, value|
            value[:winning_value] == winning_value
        end
    end

    def combo_report_of(player_cards:)
        hand = analyze hand: player_cards
        {
            :has_royal => has_royal?(hand),
            :straigth_flush => has_straight_flush?(hand),
            :four_of_a_kind => has_four_of_a_kind?(hand),
            :full_house => has_full_house?(hand),
            :flush => has_flush?(hand),
            :straight => hand[:straigth],
            :three_of_a_kind => has_three_of_a_kind?(hand),
            :two_pairs => has_two_pairs?(hand),
            :one_pair => has_one_pair?(hand),
            :max_card => true
        }
    end

    private

    def analyze(hand:)
        raise "Invalid player cards" if (hand.empty? || hand.count != 5)
        card_values = hand.map(& :values ).flatten
        hand.inject({:suite => {}, :kind => {}, :straigth => false, :min => card_values.min, :max => card_values.max}) do |collector, card|
            collector[:suite][card.keys.first] = collector[:suite][card.keys.first].to_i + 1
            collector[:kind][card.values.first.to_s] = collector[:kind][card.values.first.to_s].to_i + 1
            collector[:straigth] = card_values.sum == do_consecutive_sum(card_values.min, card_values.max)
            collector
        end
    end

    def has_flush? hand
        hand[:suite].count == 1
    end

    def has_straight? hand
        hand[:straight]
    end

    def has_straight_flush? hand
        has_flush?(hand) && is_straight?(hand)
    end

    def has_royal? hand
        has_straight_flush?(hand) && hand[:suite].has_key?(:clovers)
    end

    def has_four_of_a_kind? hand
        hand[:kind].values.include? 4
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
        pairs = hand[:kind].select do |index, value| value == 2 end
    end

    def get_three_of hand
        hand[:kind].select do |index, value| value == 3 end
    end

    def do_consecutive_sum(min, max)
        (max*(max+1))/2 - (min*(min-1))/2
    end

end

poker_handling = PokerHandling.new(players_number: 5)
# puts poker_handling.deck.count
# poker_handling.generate_table_cards
puts poker_handling.table_results.inspect
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