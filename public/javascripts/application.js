
OC = {
  
  'userdata': {},
    
  'userdata_save': function() {
    console.log('userdata save!');
    console.log(OC.userdata);
    new Ajax.Request('/users/create', { 'parameters': OC.userdata });
  },
  
  'facebook_signup': function(response) {
    console.log('login!');
    var handler = new AsyncHandler();
    FB.api('/me', function(response) {  // TODO should do fql with SELECT name, email, pic_big, hometown_location, birthday_date FROM user WHERE uid = ?
      OC.userdata = response;
      var userInfo = document.getElementById('fb-userinfo');
      userInfo.innerHTML = 'Hallo ' + response.name;
      handler.cb();
    });
    FB.api('/me/friends', function(response) {
      OC.userdata.friends_num = response.data.length;
      handler.cb();
    });
    handler.whenDone(function() {
      $('login_step1').hide();
      OC.userdata_save();
    });
  },
  
  'location2map': function() {
    if (google.loader.ClientLocation) {
      if (!Signup.map_loaded) {
        window.setTimeout(OC.location2map, 1000);
      } else {
        var point = new GLatLng(google.loader.ClientLocation.latitude, google.loader.ClientLocation.longitude);
        var marker = new GMarker(point);
        map.addOverlay(marker);
        Map.last_added_marker = marker;
        if ($('town_district')) {
          var city = google.loader.ClientLocation.address.city.replace('Vienna', 'Wien');
          if(city == 'Wien') { //Township.find(:all, :conditions => "name LIKE 'Wien%'")
            $('town_district').toggleClassName('state_district');
          } else {
            $('user_town').value = city;
          }
        }
      }
    }
  }
  
};

last_added_marker = null;

function init_toggling() {
   $$('.toggle').each(function(el) {
      el.classNames().each(function(c) {
        var parts = c.split("-",3);
        var ns = parts[0]; var name = parts[1]; var opt = parts[2];
        if (ns == 'trigger') {
          // Find target and cancel
          var target = $$('.target-'+name).first();
          var cancel = $$('.cancel-'+name).first();
          var trigger = (opt == 'hide_parent') ? el.up() : el;
          var hide = $$('.hide-'+name);
          //console.info("Initializing toggle behaviour for "+name);
          ///console.info(hide);
          el.observe('click',function(e) {
             hide.each(function(h) { h.style.display = 'none'; });
             trigger.style.old_display = trigger.style.display;
             trigger.style.display = 'none';
             target.style.display = 'block';
             e.stop();
          });
          if (cancel) {
            cancel.observe('click',function(e) {
               hide.each(function(h) { h.style.display = 'block'; });
               target.style.display = 'none';
               trigger.style.display = trigger.style.old_display;
               e.stop();
            });
          }
        }
      });
  });
}

Event.observe(window,'load', function() {
    init_toggling();
});

function handle_form_errors(prefix,fields_to_restore,errs) {
    for (field in errs) {
      fields_to_restore = fields_to_restore.without(field); // no need for restoring this one 
      var message = errs[field];
      var container = $(prefix+'_'+field);
      container.addClassName('error');
      if (message) {
        var label = $(prefix+'_'+field).down('label');
        var span = label.down('span');
        var target = span ? span : label;
        if (!target.original_text) target.original_text = target.innerHTML;
        target.update(target.original_text + '&nbsp;<i>'+message+'</i>');
      }
    }
    fields_to_restore.each(function(f) {
        var container = $(prefix+'_'+f);
        if(container) {
          var label = container.down('label');
          var span = label.down('span');
          var target = span ? span : label;
          container.removeClassName('error');
          if (target.original_text) target.update(target.original_text);
        }
    });
};

Signup = {
  fields: ['name','email','town','password'],
  handle_form_errors: function(errs) {
    handle_form_errors('signup',Signup.fields,errs);
  },
  required: function() {
    $$('.signup_required').each(function(el) {
        el.old_onclick = el.onclick;
        el.onclick = null;
        el.stopObserving('click');
        el.observe('click',function(e) {Signup.show();  e.stop(); return false; });
    });
  },
  hide: function() {
     $('signup').style.display = 'none';
  },
  restore: function() {
    if($('signup')) {
      // embedded
      $$('.signup_required').each(function(el) {
          el.stopObserving('click');
          el.onclick = el.old_onclick;
          el.old_onclick = null;
      });
      init_toggling(); //re-init toggling
      Signup.hide();
    } else {
      var target = parent ? parent : window;
      target.location.reload();
    }
  },
  show: function() {
    $('signup').style.display = 'block';
    if (!Signup.map_loaded) {
      var map = $('map');
      map.src = '/map';
      Signup.map_loaded = true;
    }
  }
};

function tab_switch(o) {
  var id = $(o).up().className[3]; //tab1 => 1
  $(o).up('.tabs').removeClassName('state-tab1');
  $(o).up('.tabs').removeClassName('state-tab2');
  $(o).up('.tabs').removeClassName('state-tab3');
  $(o).up('.tabs').removeClassName('state-tab4');
  $(o).up('.tabs').removeClassName('state-tab5');
  $(o).up('.tabs').addClassName('state-tab'+id);
  return false;
}

function highlight_box(id) {
  $(id).scrollTo();
  $(id).down('.content').style.background = '#ffd300';
  return false;
}
