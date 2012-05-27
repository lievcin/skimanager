$(document).ready(function() {

	
	    // $('see_customer').pjax('[data-pjax-container]');	
		$('input#cust_tb_filter').quicksearch('table#customers tbody tr');	
		$('input#packages_tb_filter').quicksearch('table#packages tbody tr');	
		
		var new_boot_modal=$('#modal');
		$('#new_boot_link').click(function(e) {
		  var new_boot_url = $(this).attr('href'); 
		  new_boot_modal.load(new_boot_url + ' #content',function(){
			new_boot_modal.dialog({ autoOpen: true, title: "New Boots", draggable: true,
			resizable: false, modal: true, width:'auto'});
		  });
		});
		
		var edit_boot_modal=$('#modal');
		$('#edit_boot_link').live('ajax:success', function(event, data, status, xhr){
		  var edit_boot_url = $(this).attr('href'); 
		  edit_boot_modal.load(edit_boot_url + ' #content',function(){
			edit_boot_modal.dialog({ autoOpen: true, title: "Edit Boots", draggable: true,
			resizable: false, modal: true, width:'auto'});		
		  });
		});

		var new_ski_modal=$('#modal');
		$('#new_ski_link').click(function(e) {
		  var new_ski_url = $(this).attr('href'); 
		  new_ski_modal.load(new_ski_url + ' #content',function(){
			new_ski_modal.dialog({ autoOpen: true, title: "New Skis", draggable: true,
			resizable: false, modal: true, width:'auto'});
		  });
		});
		
		var edit_ski_modal=$('#modal');
		$('#edit_ski_link').live('ajax:success', function(event, data, status, xhr){
		  var edit_ski_url = $(this).attr('href'); 
		  edit_ski_modal.load(edit_ski_url + ' #content',function(){
			edit_ski_modal.dialog({ autoOpen: true, title: "Edit Boots", draggable: true,
			resizable: false, modal: true, width:'auto'});		
		  });
		});
		
		var new_customer_modal=$('#modal');
		$('#new_customer_link').click(function(e) {
		  var new_customer_url = $(this).attr('href'); 
		  new_customer_modal.load(new_customer_url + ' #content',function(){
			new_customer_modal.dialog({ autoOpen: true, title: "New Customer", draggable: true,
					resizable: false, modal: true, width:'auto'});
		  });
		});
											
		var edit_customer_modal=$('#modal');
		$('#edit_customer_link').live('ajax:success', function(event, data, status, xhr){
		  var edit_customer_url = $(this).attr('href'); 
		  edit_customer_modal.load(edit_customer_url + ' #content',function(){
			edit_customer_modal.dialog({ autoOpen: true, title: "Edit Customer", draggable: true,
			resizable: false, modal: true, width:'auto'});		
		  });
		});
				
		
		var new_package_modal=$('#modal');
		$('#new_package_link').click(function(e) {
		  var new_package_url = $(this).attr('href'); 
		  new_package_modal.load(new_package_url + ' #content',function(){
		      var dates = $( "#package_start_date, #package_end_date" ).datepicker({
			  defaultDate: 0,
			  // minDate: 0,
			  numberOfMonths: 2,
		  			  dateFormat: "yy-mm-dd",
			  onSelect: function( selectedDate ) {
						var option = this.id == "package_start_date" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
						dates.not( this ).datepicker( "option", option, date );
						}
			  });
			new_package_modal.dialog({ autoOpen: true, title: "New Package", draggable: true,
			resizable: false, modal: true, width:'auto'});
		  });
		});

		var edit_package_modal=$('#modal');
		$('#edit_package_link').live('ajax:success', function(event, data, status, xhr){
		  var edit_package_url = $(this).attr('href'); 
		  edit_package_modal.load(edit_package_url + ' #content',function(){
		      var dates = $( "#package_start_date, #package_end_date" ).datepicker({
			  defaultDate: 0,
			  // minDate: 0,
			  numberOfMonths: 2,
			  dateFormat: "yy-mm-dd",
			  onSelect: function( selectedDate ) {
						var option = this.id == "package_start_date" ? "minDate" : "maxDate",
						instance = $( this ).data( "datepicker" ),
						date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
						dates.not( this ).datepicker( "option", option, date );
						}
			  });
			edit_package_modal.dialog({ autoOpen: true, title: "Edit Package", draggable: true,
			resizable: false, modal: true, width:'auto'});
		  });
		});
					
	});



(function($, window, document, undefined) {
	$.fn.quicksearch = function (target, opt) {
		
		var timeout, cache, rowcache, jq_results, val = '', e = this, options = $.extend({ 
			delay: 100,
			selector: null,
			stripeRows: null,
			loader: null,
			noResults: '',
			bind: 'keyup',
			onBefore: function () { 
				return;
			},
			onAfter: function () { 
				return;
			},
			show: function () {
				this.style.display = "";
			},
			hide: function () {
				this.style.display = "none";
			},
			prepareQuery: function (val) {
				return val.toLowerCase().split(' ');
			},
			testQuery: function (query, txt, _row) {
				for (var i = 0; i < query.length; i += 1) {
					if (txt.indexOf(query[i]) === -1) {
						return false;
					}
				}
				return true;
			}
		}, opt);
		
		this.go = function () {
			
			var i = 0, 
			noresults = true, 
			query = options.prepareQuery(val),
			val_empty = (val.replace(' ', '').length === 0);
			
			for (var i = 0, len = rowcache.length; i < len; i++) {
				if (val_empty || options.testQuery(query, cache[i], rowcache[i])) {
					options.show.apply(rowcache[i]);
					noresults = false;
				} else {
					options.hide.apply(rowcache[i]);
				}
			}
			
			if (noresults) {
				this.results(false);
			} else {
				this.results(true);
				this.stripe();
			}
			
			this.loader(false);
			options.onAfter();
			
			return this;
		};
		
		this.stripe = function () {
			
			if (typeof options.stripeRows === "object" && options.stripeRows !== null)
			{
				var joined = options.stripeRows.join(' ');
				var stripeRows_length = options.stripeRows.length;
				
				jq_results.not(':hidden').each(function (i) {
					$(this).removeClass(joined).addClass(options.stripeRows[i % stripeRows_length]);
				});
			}
			
			return this;
		};
		
		this.strip_html = function (input) {
			var output = input.replace(new RegExp('<[^<]+\>', 'g'), "");
			output = $.trim(output.toLowerCase());
			return output;
		};
		
		this.results = function (bool) {
			if (typeof options.noResults === "string" && options.noResults !== "") {
				if (bool) {
					$(options.noResults).hide();
				} else {
					$(options.noResults).show();
				}
			}
			return this;
		};
		
		this.loader = function (bool) {
			if (typeof options.loader === "string" && options.loader !== "") {
				 (bool) ? $(options.loader).show() : $(options.loader).hide();
			}
			return this;
		};
		
		this.cache = function () {
			
			jq_results = $(target);
			
			if (typeof options.noResults === "string" && options.noResults !== "") {
				jq_results = jq_results.not(options.noResults);
			}
			
			var t = (typeof options.selector === "string") ? jq_results.find(options.selector) : $(target).not(options.noResults);
			cache = t.map(function () {
				return e.strip_html(this.innerHTML);
			});
			
			rowcache = jq_results.map(function () {
				return this;
			});
			
			return this.go();
		};
		
		this.trigger = function () {
			this.loader(true);
			options.onBefore();
			
			window.clearTimeout(timeout);
			timeout = window.setTimeout(function () {
				e.go();
			}, options.delay);
			
			return this;
		};
		
		this.cache();
		this.results(true);
		this.stripe();
		this.loader(false);
		
		return this.each(function () {
			$(this).bind(options.bind, function () {
				val = $(this).val();
				e.trigger();
			});
		});
		
	};
}(jQuery, this, document));
