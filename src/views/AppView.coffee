class window.AppView extends Backbone.View
  initialize: ->
    @blackjackView = new BlackjackView(model: new Blackjack());
    @render()

  render: ->
    @$el.append @blackjackView.el
