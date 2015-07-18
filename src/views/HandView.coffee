class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'reveal', => @render()

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection

    cards = $('<div>')
      .addClass "card-container"
      .append @collection.map (card) ->
        new CardView(model: card).$el

    scores = @collection.scores()
    score = scores[0] + ''
    if scores[1] <= 21 and scores[1] != scores[0] then score += ' or ' + scores[1]

    if @collection.length == 2 and scores[0] == 21 then score = 'Blackjack!'

    @$('.score').text score

    @$el.append cards

