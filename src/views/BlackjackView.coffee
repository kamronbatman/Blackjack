class window.BlackjackView extends Backbone.View
  #model -> Blackjack

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="deal-button">Deal</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="results"><h2><span id="results"> </span></h2></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .deal-button': -> @model.deal()

  initialize: ->
    @render()

    @model.on 'endGame', (score) ->
      @$('.hit-button').prop('disabled', true)
      @$('.stand-button').prop('disabled', true)
      @$('#results').text score
    , @

    @model.on 'deal', () ->
      @render()
      @$('.hit-button').prop('disabled', false)
      @$('.stand-button').prop('disabled', false)
    , @
    return

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el