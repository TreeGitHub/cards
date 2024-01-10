defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """
  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Daimonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Returns a list of strings representing a shuffled a deck of playing cards.
    The `deck` argument contains the deck of cards to be shuffled.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns true or false indicating whether the `card` is in the `deck` of playing cards.

  ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Dvides the deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves the passed in `deck` to a file specified im the `filename`.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a deck of cards from a file specified in the `filename`.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
    Creates a hand of playing cards by first creating and shffling a list of strings representing a deck of playing cards, then dealing a hand of cards.
    The `hand_size` argument indicates how many cards should be in the hand.
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
