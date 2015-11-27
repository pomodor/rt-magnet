$(document).ready(function() {
    $('#torrent-name').keydown(function(event) {
        if (event.keyCode == 13) {
      		torrentDbQuery();
            return false;
         }
    });
});

var torrentDbQuery = function() {
  var query = $('#torrent-name').val();
  $.ajax({
	method: 'get',
	url: '/ajax/search',
	dataType: 'json',
	data: { query: query }
  }).done(function(r) {
	  if (r.status === 'ok') {
		$('#torrent-name').val('');
		$('#results').empty();
		r.data.forEach(function(torrent) {
		  $('#results').append('<p class="result-item">' +
			'<a href="magnet:?xt=urn:btih:' + torrent.magnet + '">' +
			'<span class="glyphicon glyphicon-globe"></span></a>&nbsp;&nbsp;' +
			torrent.name +
			'</p>');
		});
	  } else if (r.status === 'fail') {
		$('#torrent-name').html('Error: ' + r.message);
	  }
	});
}