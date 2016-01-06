$ ->
    $('ul.offer-index-tab li').click ->
        clicked_class = $(this).attr('class');
        $('div.offer-index div:not(.'+clicked_class+')').slideUp(100);
        $('div.offer-index div.'+clicked_class).slideDown(100);
    $('div.offer-index h2').click ->
        clicked_class = $(this).attr('class');
        console.log(clicked_class);
        $('div.offer-index div.'+clicked_class).slideDown(100);

# $(document).ready(ready)
# $(document).on('page:load', ready)