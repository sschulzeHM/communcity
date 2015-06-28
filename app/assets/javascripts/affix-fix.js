$(document).ready(function() {

    $('body').on('affixed.bs.affix', function(event) {$('.affix-spacer').show();});
    $('body').on('affixed-top.bs.affix', function(event) { $('.affix-spacer').hide();});
})
