class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @newDeck()

  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

  newDeck: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  cardsLeft: -> @length

#Out of cards?
#Generate new deck