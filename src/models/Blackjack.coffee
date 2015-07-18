# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.Blackjack extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @deal()
    return

  deal: ->
    deck = @get 'deck'
    if deck.cardsLeft() < 12 then deck.newDeck()
    @set 'playerHand', (@get 'deck').dealPlayer()
    @set 'dealerHand', (@get 'deck').dealDealer()
    @trigger 'deal', @
    return