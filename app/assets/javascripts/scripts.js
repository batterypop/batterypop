jQuery(document).ready(function() {


    //Function to prevent Default Events
    function pde(e) {
        if (e.preventDefault)
            e.preventDefault();
        else
            e.returnValue = false;
    }



    // Minify the Nav Bar
    $(document).scroll(function () {
        var position = $(document).scrollTop();
        var headerHeight = $('#header').outerHeight();
        if (position >= headerHeight - 100) {
            $('.navbar').addClass('minified');
        } else {
            $('.navbar').removeClass('minified');
        }



    });




    jQuery('a[rel="external"]')
    .click( function() {
        window.open( jQuery(this).attr('href') );
        pde(evt);
    });


    jQuery('.slider ul').bxSlider({
        infiniteLoop: true,
        pager: false, 
        auto: true,
        width: 800, 
        minSlides: 1,
        maxSlides: 1,
        infiniteLoop: true
        //preventDefaultSwipeY: true
    });


    jQuery('.carousel-vertical ul').bxSlider({
        mode: 'vertical',
        slideMargin: 10,
        minSlides: 3,
        pager: false,
        infiniteLoop: false,
        adaptiveHeight: true,
        responsive: true,
        touchEnabled: false,
        moveSlides: 0,
        hideControlOnEnd: true
        //preventDefaultSwipeY: true
    });

    jQuery('.col-md-12 .carousel-horizontal ul').bxSlider({
        mode: 'horizontal',
        slideMargin: 10,
        minSlides: 2,
        maxSlides: 6,
        pager: false,
        infiniteLoop: false,
        responsive: true,
        touchEnabled: true,
        moveSlides: 0,
        slideWidth: 212,
        hideControlOnEnd: true
        //preventDefaultSwipeY: true
    });


    jQuery('.col-md-8 .carousel-horizontal ul').bxSlider({
        mode: 'horizontal',
        slideMargin: 10,
        minSlides: 2,
        maxSlides: 4,
        pager: false,
        infiniteLoop: false,
        responsive: true,
        touchEnabled: true,
        moveSlides: 0,
        slideWidth: 230,
        hideControlOnEnd: true
    });

    jQuery('.col-md-7 .carousel-horizontal ul').bxSlider({
        mode: 'horizontal',
        slideMargin: 10,
        minSlides: 2,
        maxSlides: 4,
        pager: false,
        infiniteLoop: false,
        responsive: true,
        touchEnabled: true,
        moveSlides: 0,
        slideWidth: 203,
        hideControlOnEnd: true
    });


    $('.pop-over').popover();

});

// fitvids
  jQuery(document).ready(function($){
    // Target your .container, .wrapper, .post, etc.
    $(".videocontent").fitVids();
  });




// equalize height
  jQuery(document).ready(function($) {
    $(".headcrumb").eqHeight(".column");
});



// doubleclick ads 
var googletag = googletag || {};
googletag.cmd = googletag.cmd || [];
(function() {
var gads = document.createElement('script');
gads.async = true;
gads.type = 'text/javascript';
var useSSL = 'https:' == document.location.protocol;
gads.src = (useSSL ? 'https:' : 'http:') + 
'//www.googletagservices.com/tag/js/gpt.js';
var node = document.getElementsByTagName('script')[0];
node.parentNode.insertBefore(gads, node);
})();

googletag.cmd.push(function() {
googletag.defineSlot('/31902320/Homepage_Leaderboard', [[728, 90], [970, 90]], 'div-gpt-ad-1401977811996-0').addService(googletag.pubads());
googletag.defineSlot('/31902320/Homepage_MedRed', [[300, 600], [320, 50]], 'div-gpt-ad-1402367992718-0').addService(googletag.pubads());

googletag.pubads().enableSingleRequest();
googletag.enableServices();
});

// doubleclick sidebar
// var googletag = googletag || {};
// googletag.cmd = googletag.cmd || [];
// (function() {
// var gads = document.createElement('script');
// gads.async = true;
// gads.type = 'text/javascript';
// var useSSL = 'https:' == document.location.protocol;
// gads.src = (useSSL ? 'https:' : 'http:') + 
// '//www.googletagservices.com/tag/js/gpt.js';
// var node = document.getElementsByTagName('script')[0];
// node.parentNode.insertBefore(gads, node);
// })();


// googletag.cmd.push(function() {
// googletag.defineSlot('/31902320/Homepage_MedRed', [[300, 600], [320, 50]], 'div-gpt-ad-1402367992718-0').addService(googletag.pubads());
// googletag.pubads().enableSingleRequest();
// googletag.enableServices();
// });
