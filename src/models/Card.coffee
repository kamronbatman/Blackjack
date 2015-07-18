class window.Card extends Backbone.Model
  initialize: (params) ->
    @set
      revealed: true
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['c', 's', 'h', 'd'][params.suit]
      rankName: switch params.rank
        when 0 then 'k'
        when 1 then 'a'
        when 11 then 'j'
        when 12 then 'q'
        else params.rank
    @set
      cardName: "#{@get 'rankName'}" + @get 'suitName'

  flip: ->
    @set 'revealed', !@get 'revealed'
    @