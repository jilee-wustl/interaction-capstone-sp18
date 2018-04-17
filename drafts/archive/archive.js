$(document).ready(function(){
           
           function doneLoadingDatabase() {
            
            // for each post
            for (var a = 1; a <= postNum; a++) {
                
                //placing button for input & output 
                for (var b = 1; b < 3; b++) {
                    var textDivName = '#io-' + a + '-' + b;
                    var btnDivName = '#btn-t-' + a + '-' + b;
                    var divHeight = $(textDivName).height();
                    $(btnDivName).css('min-height', divHeight+'px');
                }
                
                //placing button in the middle of input & output
                var postHeight = $('#insidePost-' + a).height();
                $('#btn-m-'+a).css('min-height', postHeight);

            }
            $("#archive").fadeIn();
           }
            
            
            
            //hover effect for each language
            $('.txtWrapper').mouseenter (function() {
                
                var wrapperId = this.id;

                var eng = '#' + wrapperId + '-eng';
                var orig = '#' + wrapperId + '-orig';
                
                var boldSpan = '#lang-' + wrapperId;
                                
                $(orig).show();
                $(eng).hide();
                $(boldSpan).css('font-weight', 500);
            });
            
            $('.txtWrapper').mouseleave (function() {
                
                var wrapperId = this.id;

                var eng = '#' + wrapperId + '-eng';
                var orig = '#' + wrapperId + '-orig';
                
                var boldSpan = '#lang-' + wrapperId;

                $(orig).hide();
                $(eng).show();
                $(boldSpan).css('font-weight', 300);
            });
            
            
            
            //when open button is clicked
            $('.btn-o').click(function() {
                var btnValue = this.value;
                var btnName = '.btn-btw-' + btnValue;
                var btnDotName = '#btn-m-' + btnValue;

                $(this).fadeOut();
                $(btnDotName).fadeOut();

                $(btnName).hide();
                                
                setTimeout(function() {
                    calculate(btnValue);
                }, 600);
                
                setTimeout(function() {
                    showBtn(btnValue);
                }, 600);
            });
            
            
            function calculate(val) {
                var postHeight = $('#insidePost-'+val).actual('height');
                
                console.log(postHeight);
                
                var btnName = '#btn-m-'+val;
                
                $(btnName).css('min-height', postHeight+'px');
                                
                for (var x = 1; x <=10; x++){
                    var divName = '#text-' + val + '-' + x;
                    var btnMidName = '#btn-e-' + val + '-' + x;
                    var individualHeight = $(divName).actual('height');
                    $(btnMidName).css('min-height', individualHeight+'px');
                }
                
                $(btnName).fadeIn(1200);
            }
            
            
            //in between translation button clicked
            $('.btn-btw').click(function() {
                var btnValue = this.value;
                var collapseName = '#collapse-' + btnValue;
                var btnMidName = '#btn-m-' + btnValue;
                
                $(collapseName).collapse('hide');
                $(btnMidName).hide();

                setTimeout(function() {
                    calculate(btnValue);
                }, 600);
                
                setTimeout(function() {
                    showMidBtn(btnValue);
                }, 700);
            });
            
            
            
            function showMidBtn(val) {
                var name = '#btn-o-' + val;
                $(name).fadeIn(1000);
            }
            
            function showBtn(val) {
                var name = '.btn-btw-' + val;
                $(name).fadeIn();
            }
            
        });