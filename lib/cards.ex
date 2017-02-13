defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of string representing a deck of cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end
  
  def shuffle(deck) do
    Enum.shuffle(deck)
  end
  
  @doc """
    Determines whether a deck contains a single card.
  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "King")
      false
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck,card) do
    Enum.member?(deck,card)
  end
  
  @doc """
    Returns a tuple, elements of which have the hand and the remaining deck.
    The `hand_size` argument indicates how many cards should be in hand.
  ## Examples
      iex> deck = Cards.create_deck
      iex>{hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
  
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end
  
  def load(filename) do
    case File.read filename do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _errormsg} -> "File not found"
    end
  end
  
  def create_hand(hand_size) do
    Cards.create_deck 
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
