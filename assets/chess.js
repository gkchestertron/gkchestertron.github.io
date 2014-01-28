console.log('ready')

$(function () {
console.log('ready');
function getFile(filename) {
	var client = new XMLHttpRequest();
	client.open('GET', '/samples/chess/' + filename + '.rb');
	client.onload = function () { updateCode(client.response) };
	client.send();
}

function updateCode (text) {
	$('pre').text(text);
}

$('.chessLink').on('click', function (event) {
	console.log('clicking')
	event.preventDefault();
	var filename = $(event.target).text();
	getFile(filename);
})

});