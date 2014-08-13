var router = require('./..')();
router.on(/[\w\s]+/, function (foo, bar, baz, next, end) {
  foo.msg = 'foo';
  // trigger an error so our handler can catch it
  next(new Error());
});
router.on(function (err, foo, bar, baz, next, end) {
  // our error handler captured it, so call next without the error to get back on track
  next();
});
router.on('some*', function (foo, bar, baz, next, end) {
  // update bar
  bar.msg = 'bar';
  next();
});
router.on('some event', function (foo, bar, baz, next, end) {
  // update baz
  baz.msg = 'baz';
  next();
});
router.on(/event/, function (foo, bar, baz, next, end) {
  end();
});
router('some event', {}, {}, {}, function (err, foo, bar, baz) {
  console.log(err, foo, bar, baz) 
});
