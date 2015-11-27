var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('front', { title: 'Локальный поиск по раздачам rutracker.org' });
});


module.exports = router;
