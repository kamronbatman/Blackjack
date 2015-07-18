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

    dealer = @get 'dealerHand'
    player = @get 'playerHand'

    (@get 'playerHand').on 'stand', =>
      @stand()

    (@get 'playerHand').on 'hit', (hand) =>
      @hit(hand)

    @trigger 'deal', @

    pB = player.hasBlackjack()
    dB = dealer.hasBlackjack()

    `console.log('pb', pB, 'db', dB)`

    if pB or dB
      dealer.revealCard()
      @endGame()

    return

  hit: (hand) ->
    scores = hand.scores()
    if scores[0] > 21 then @endGame()
    else if scores[0] == 21 or scores[1] == 21 then @stand()

  stand: ->
    #Reveal the card for the dealer
    #Deal the dealer's cards
    #Determine winner/loser

    dealer = (@get 'dealerHand')
    dealer.revealCard()

    scores = dealer.scores()

    while scores[1] < 17 or (scores[0] < 17 and scores[1] > 21) or (scores[0] == 7 and scores[1] == 17)
      dealer.hit()
      scores = dealer.scores()

    @endGame()

  endGame: ->
    player = @get 'playerHand'
    dealer = @get 'dealerHand'
    pscores = player.scores()
    dscores = dealer.scores()

    scoreMessage = ''

    pscore = if pscores[1] <= 21 then pscores[1] else pscores[0]
    dscore = if dscores[1] <= 21 then dscores[1] else dscores[0]

    pB = player.hasBlackjack()
    dB = dealer.hasBlackjack()

    if pscore > 21 then scoreMessage = 'You Busted!'
    else if pB and !dB then scoreMessage = 'Blackjack!'
    else if dscore > 21 or pscore > dscore then scoreMessage = 'You win!'
    else if pB and dB or pscore == dscore then scoreMessage = 'Push!'
    else scoreMessage = 'You lose!'

    @trigger 'endGame', scoreMessage


#3 A A A A JACK
#min -> 7
#max -> 17