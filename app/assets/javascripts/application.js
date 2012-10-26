// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.mobile

$(document).on("pageinit", "#index-page", function (){
    var current_page = 1,
        current_city = null,
        access_token = escape($("#access_token").text());

    $("#button_more").click(function() {
        current_page ++;
        if (current_city === null) {
            $.getScript('/events.js?user_access_token=' + access_token + '&page=' + current_page);
        } else {
            $.getScript('/events.js?user_access_token=' +  access_token + '&page=' + current_page + '&city=' + current_city);
        }
    });

    $("select.select-button").change(function () {
        current_page = 1;
        $("#events_list li").remove();
        var city_value = $("select.select-button option:selected").val();
        if (city_value === "all") {
            current_city = null;
            $.getScript('/events.js?user_access_token=' +  access_token);
        } else {
            current_city = city_value;
            $.getScript('/events.js?user_access_token=' +  access_token + '&page=1&city=' + current_city);
        }
    });
});