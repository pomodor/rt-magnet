var express = require('express');
var router = express.Router();

var db = require('../config/database.js');

router.get('/search', function(req, res, next) {
  var q = req.query.query;
  console.log(q);
  q = q.split(' ').join("%' and name like '%");
  var query = "select name, magnet from torrents " +
	"where name like '%" + q + "%'";
  console.dir(query);
	
  db.query(query, function(error, row) {
	if (error) {
	  res.json({ status: 'fail', message: error });
	} else {
		res.json({ status: 'ok', data: row });
	}
  });
});

module.exports = router;
