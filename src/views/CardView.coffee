class window.CardView extends Backbone.View
  className: 'card'

  #template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<% if(revealed){ %><img src="img/fablecards/<%= cardName %>.png"><% } %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'