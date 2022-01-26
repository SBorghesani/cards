defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

###The following will return nested arrays###
### wrong way to handle: ###
  #   for value <- values do
  #     for suit <- suits do
  #       "#{value} of #{suit}"
  #     end
  #   end
  # end

### A not so elegant solution for nested arrays: (List.flatten)###
  #   cards = for value <- values do
  #     for suit <- suits do
  #       "#{value} of #{suit}"
  #     end
  #   end
  #     List.flatten(cards)
  # end

### The better way to use comprehension ###
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    #How we invoke erlang code: <:erlang>
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end



###This works, but it could be cleaner###
  # def load(filename) do
  #   {status, binary} = File.read(filename)

  #   case status do
  #     :ok -> :erlang.binary_to_term(binary)
  #     :error -> "That file does not exist"
  #   end
  # end


###Cleaner code: ###
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end




end
