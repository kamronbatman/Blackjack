class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @trigger 'hit', @

  stand: ->
    @trigger 'stand', @

  hasAce: (hidden) -> @reduce (memo, card) ->
    memo or ((hidden or card.get('revealed')) and card.get('value') is 1)
  , 0

  minScore: (hidden) -> @reduce (score, card) ->
    score + if (card.get 'revealed') or hidden then card.get 'value' else 0
  , 0

  hasBlackjack: ->
    (@minScore(true) + (10 * @hasAce(true))) == 21 and @length == 2

  revealCard: ->
    (@at 0).flip()
    @trigger 'reveal', @

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + (10 * @hasAce())]


