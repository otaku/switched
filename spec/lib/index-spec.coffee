describe 'lib', ->
  
  Given -> @lib = requireSubject 'lib', {
    './../package.json':
      version: 1
  }

  describe '.version', ->

    When -> @version = @lib.version
    Then -> expect(@version).toEqual 1

  describe '#', ->

    Given -> @res = @lib()
    Then -> expect(@res instanceof @lib).toBe true
  
  describe 'prototype', ->

    Given -> @router = @lib()
    Given -> @name = 'some event'
    Given -> @arg = some: 'data'
    Given -> @cb = jasmine.createSpy 'cb'
    
    describe '#', ->

      Given -> spyOn @router, 'route'
      When -> @router @name, @arg, @cb
      And -> expect(@router.route).toHaveBeenCalledWith @name, @arg, @cb

    describe '#route (name:String, arg:mixed)', ->

      Given -> @order = []
      Given -> @a = jasmine.createSpy 'a'
      Given -> @b = jasmine.createSpy 'b'
      Given -> @c = jasmine.createSpy 'c'
      Given -> @d = jasmine.createSpy 'd'
      Given -> @e = jasmine.createSpy 'e'
      Given -> @f = jasmine.createSpy 'f'
      Given -> @error = new Error 'something wrong'
      Given -> @foo = (arg, next) => @a(); @order.push('a'); next()
      Given -> @bar = (arg, next) => @b(); @order.push('b'); next()
      Given -> @baz = (arg, next) => @c(); @order.push('c'); next @error
      Given -> @err = (err, arg, next) => @d err; @order.push('d'); next err
      Given -> @err1 = (err, arg, next) => @e err; @order.push('e'); next()
      Given -> @cra = (arg, next) => @f(); @order.push('f'); next()
      Given -> @path = [@foo, @bar, @err, @baz, @err1, @cra]
      Given -> @router.use @path
      Given -> spyOn(@router,['getPath']).andCallThrough()
      When -> @router.route @name, @arg
      Then -> expect(@router.getPath).toHaveBeenCalledWith @name
      And -> expect(@a).toHaveBeenCalled()
      And -> expect(@b).toHaveBeenCalled()
      And -> expect(@c).toHaveBeenCalled()
      And -> expect(@d).not.toHaveBeenCalled()
      And -> expect(@e).toHaveBeenCalledWith @error
      And -> expect(@f).toHaveBeenCalled()
      And -> expect(@order).toEqual ['a', 'b', 'c', 'e', 'f']

    describe '#route (name:String, arg:mixed)', ->

      Given -> @order = []
      Given -> @a = jasmine.createSpy 'a'
      Given -> @b = jasmine.createSpy 'b'
      Given -> @c = jasmine.createSpy 'c'
      Given -> @d = jasmine.createSpy 'd'
      Given -> @e = jasmine.createSpy 'e'
      Given -> @f = jasmine.createSpy 'f'
      Given -> @error = new Error 'something wrong'
      Given -> @foo = (arg, next) => @a(); @order.push('a'); next()
      Given -> @bar = (arg, next) => @b(); @order.push('b'); next()
      Given -> @baz = (arg, next) => @c(); @order.push('c'); next @error
      Given -> @err = (err, arg, next) => @d err; @order.push('d'); next err
      Given -> @err1 = (err, arg, next, end) => @e err; @order.push('e'); end()
      Given -> @cra = (arg, next) => @f(); @order.push('f'); next()
      Given -> @path = [@foo, @bar, @err, @baz, @err1, @cra]
      Given -> @router.use @path
      Given -> spyOn(@router,['getPath']).andCallThrough()
      When -> @router.route @name, @arg
      Then -> expect(@router.getPath).toHaveBeenCalledWith @name
      And -> expect(@a).toHaveBeenCalled()
      And -> expect(@b).toHaveBeenCalled()
      And -> expect(@c).toHaveBeenCalled()
      And -> expect(@d).not.toHaveBeenCalled()
      And -> expect(@e).toHaveBeenCalledWith @error
      And -> expect(@f).not.toHaveBeenCalled()
      And -> expect(@order).toEqual ['a', 'b', 'c', 'e']

    describe '#route (name:String, arg:mixed, cb:Function)', ->

      Given -> @order = []
      Given -> @a = jasmine.createSpy 'a'
      Given -> @b = jasmine.createSpy 'b'
      Given -> @c = jasmine.createSpy 'c'
      Given -> @d = jasmine.createSpy 'd'
      Given -> @e = jasmine.createSpy 'e'
      Given -> @f = jasmine.createSpy 'f'
      Given -> @error = new Error 'something wrong'
      Given -> @foo = (arg, next) => @a(); @order.push('a'); next()
      Given -> @bar = (arg, next) => @b(); @order.push('b'); next()
      Given -> @baz = (arg, next) => @c(); @order.push('c'); next @error
      Given -> @err = (err, arg, next) => @d err; @order.push('d'); next err
      Given -> @err1 = (err, arg, next) => @e err; @order.push('e'); next()
      Given -> @cra = (arg, next) => @f(); @order.push('f'); next()
      Given -> @path = [@foo, @bar, @err, @baz, @err1, @cra]
      Given -> @router.use @path
      Given -> spyOn(@router,['getPath']).andCallThrough()
      When -> @router.route @name, @arg, @cb
      Then -> expect(@router.getPath).toHaveBeenCalledWith @name
      And -> expect(@a).toHaveBeenCalled()
      And -> expect(@b).toHaveBeenCalled()
      And -> expect(@c).toHaveBeenCalled()
      And -> expect(@d).not.toHaveBeenCalled()
      And -> expect(@e).toHaveBeenCalledWith @error
      And -> expect(@f).toHaveBeenCalled()
      And -> expect(@cb).toHaveBeenCalled()
      And -> expect(@order).toEqual ['a', 'b', 'c', 'e', 'f']

    describe '#route (err:Error, arg:Object, args:Array)', ->

      Given -> @order = []
      Given -> @cb = jasmine.createSpy 'cb'
      Given -> @a = jasmine.createSpy 'a'
      Given -> @b = jasmine.createSpy 'b'
      Given -> @c = jasmine.createSpy 'c'
      Given -> @d = jasmine.createSpy 'd'
      Given -> @e = jasmine.createSpy 'e'
      Given -> @f = jasmine.createSpy 'f'
      Given -> @error = new Error 'something wrong'
      Given -> @foo = (arg, next) => @a(); @order.push('a'); next()
      Given -> @bar = (arg, next) => @b(); @order.push('b'); next()
      Given -> @baz = (arg, next) => @c(); @order.push('c'); next @error
      Given -> @err = (err, arg, next) => @d err; @order.push('d'); next err
      Given -> @err1 = (err, arg, next) => @e err; @order.push('e'); next()
      Given -> @cra = (arg, next) => @f(); @order.push('f'); next()
      Given -> @path = [@foo, @bar, @err, @baz, @err1, @cra]
      Given -> @router.use @path
      Given -> spyOn(@router,['getPath']).andCallThrough()
      When -> @router.route @name, @error, @arg, @cb
      Then -> expect(@router.getPath).toHaveBeenCalledWith @name
      And -> expect(@a).not.toHaveBeenCalled()
      And -> expect(@b).not.toHaveBeenCalled()
      And -> expect(@c).not.toHaveBeenCalled()
      And -> expect(@d).toHaveBeenCalled()
      And -> expect(@e).toHaveBeenCalledWith @error
      And -> expect(@f).toHaveBeenCalled()
      And -> expect(@cb).toHaveBeenCalled()
      And -> expect(@order).toEqual ['d', 'e', 'f']

    describe '#use', ->

      Given -> @test = => @router.use()
      Then -> expect(@test).toThrow new Error 'expecting at least one parameter'

    describe '#use (name:Sring)', ->

      Given -> @test = => @router.use 'some event'
      Then -> expect(@test).toThrow new Error 'we have the name, but need a handler'

    describe '#use (regexp:RegExp)', ->

      Given -> @test = => @router.use /^w+/
      Then -> expect(@test).toThrow new Error 'we have the name, but need a handler'

    describe '#use (fn:Function)', ->

      Given -> @fn = (arg, next) ->
      When -> @router.use @fn
      Then -> expect(@router.fns().length).toBe 1

    describe '#use (router:Router)', ->

      Given -> @a = @lib()
      When -> @router.use @a
      Then -> expect(@router.fns().length).toBe 1
      And -> expect(@router.fns()[0][1]).toEqual @a

    describe '#use (name:String,fn:Function)', ->

      Given -> @name = 'name'
      Given -> @fn = (arg, next) ->
      When -> @router.use @name, @fn
      Then -> expect(@router.fns(@name).length).toBe 1

    describe '#use (regexp:RegExp,fn:Function)', ->

      Given -> @name = /\w+/
      Given -> @fn = (arg, next) ->
      When -> @router.use @name, @fn
      Then -> expect(@router.fns(@name).length).toBe 1

    describe '#use (name:Array)', ->

      Given -> @a = ->
      Given -> @b = ->
      Given -> @c = ->
      Given -> @name = [@a, @b, @c]
      When -> @router.use @name
      Then -> expect(@router.fns()).toEqual [[0,@a], [1,@b], [2,@c]]

    describe '#on', ->

      Then -> expect(@router.on).toEqual @router.use

    describe '#getPath (name:String)', ->

      Given -> @a = jasmine.createSpy 'a'
      Given -> @b = jasmine.createSpy 'b'
      Given -> @c = jasmine.createSpy 'c'
      Given -> @d = jasmine.createSpy 'd'
      Given -> @router.use 'test*', @a
      Given -> @router.use 'tes*', @b
      Given -> @router.use 't*r', @c
      Given -> @router.use /^\w+/, @d

      describe 'name matches', ->

        Given -> @name = 'tester'
        When -> @res = @router.getPath @name
        Then -> expect(@res).toEqual [@a, @b, @c, @d]

      describe 'name does not matches', ->

        Given -> @name = '!sleeper'
        When -> @res = @router.getPath @name
        Then -> expect(@res).toEqual []

    describe '#index', ->

      When -> expect(@router.index()).toBe 0
      When -> expect(@router.index()).toBe 1
      When -> expect(@router.index()).toBe 2

    describe '#fns', ->

      When -> @res = @router.fns()
      Then -> expect(@res).toEqual []

    describe '#fns (name:String="test")', ->

      Given -> @name = 'test'
      When -> @res = @router.fns @name
      Then -> expect(@res).toEqual []

    describe '#_fns', ->

      When -> @res = @router._fns()
      Then -> expect(@res).toEqual {}
