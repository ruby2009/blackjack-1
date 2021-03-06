require_relative 'card'
require_relative 'deck'
require 'tty'

class Game

attr_accessor :deck,
              :player_hand,
              :dealer_hand,
              :prompt

  def initialize
    @deck = Deck.new
    @player_hand = []
    @dealer_hand = []
    @prompt = TTY::Prompt.new
    2.times do
      @player_hand << deck.cards.shift
      @dealer_hand << deck.cards.shift
    end
  end

def play
  until player_hand.inject(0) {|sum, card| sum + card.value} >= 21 do player_turn
  end
  dealer_turn
end

def player_turn
    puts "You have:"
    player_hand.each do |card|
      puts card
    end
    desire = prompt.yes?("Would you like to hit? y/n")
    if desire
      player_hand << deck.cards.shift
    else
      dealer_turn
    end
end

def dealer_turn
  dealer_hand.inject(0) {|sum, card| sum + card.value}
  until dealer_hand.inject(0) {|sum, card| sum + card.value} > 15
    dealer_hand << deck.cards.shift
  end
  game_over
end

def game_over
  if player_hand.inject(0) {|sum, card| sum + card.value} > 21
    puts "you lose"
  elsif player_hand.inject(0) {|sum, card| sum + card.value} == dealer_hand.inject(0) {|sum, card| sum + card.value}
    puts "you win"
  elsif player_hand.inject(0) {|sum, card| sum + card.value} > dealer_hand.inject(0) {|sum, card| sum + card.value}
    puts "you win"
  else
    puts "you lose"
  end
end

end

Game.new.play
