@toDoDemoApp.factory 'serverInterface', [ '$http', '$resource', '$q', 'errorHandler',  ($http, $resource, $q, errorHandler) ->
  class serverInterface

    constructor: (url, @list )->
      @service = $resource("#{url}:id",
        {id: '@id'},
        {update: {method: 'PATCH'}})

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (object) ->
      deferred = $q.defer()
      new @service(model: object).$save ((data) =>
        if data.success
          @list.push(data.model)
          deferred.resolve(data.model)
        else
          errorHandler.process(data.errors)
       )

      return deferred.promise

    delete: (object) ->
      if @list.indexOf(object) >= 0
        new @service().$delete {id: object.id}, ( ()=>
          index = @list.indexOf(object)
          @list.splice index, 1
          )

    update: (object) ->
      deferred = $q.defer()
      new @service(model: object).$update {id: object.id}, ( (data) =>
          if data.success
            index = @list.indexOf(object)
            @list.splice index, 1
            @list.push(data.model)
            console.log("updated data")
            console.log(data.model)
            deferred.resolve(data.model)
          else
            errorHandler.process(data.errors)
        )

      return deferred.promise

    show: (id) ->
      deferred = $q.defer()
      new @service().$get {id: id}, ((data) =>
        if data?
          deferred.resolve(data.model)
        else
          errorHandler.process("Server Error please try later")
      )

    all: (parent) ->
      deferred = $q.defer()
      @service.query(parent_id: parent).$promise.then( (data) =>
        if data?
          for model in @list
            @list.pop()
          for model in data
            @list.push(model)
          console.log('index data')
          console.log(data)
          deferred.resolve(@list)
        else
          errorHandler.process("Server Error please try later")
      )
      return deferred.promise



]