class Teaspoon.Jasmine2.Spec

  constructor: (@spec) ->
    @fullDescription = @spec.fullName
    @description = @spec.description
    @link = "?grep=#{encodeURIComponent(@fullDescription)}"
    @parent = @spec.parent
    @suiteName = @parent.fullName
    @viewId = @spec.id
    @pending = @spec.status == "pending"


  errors: ->
    return [] unless @spec.failedExpectations.length
    for item in @spec.failedExpectations
      {message: item.message, stack: item.stack}


  getParents: ->
    return @parents if @parents
    @parents ||= []
    parent = @parent
    while parent
      parent = new Teaspoon.Jasmine2.Suite(parent)
      @parents.unshift(parent)
      parent = parent.parent
    @parents


  result: ->
    status: @status()
    skipped: @spec.status == "disabled"


  status: ->
    if @spec.status == "disabled" then "passed" else @spec.status
