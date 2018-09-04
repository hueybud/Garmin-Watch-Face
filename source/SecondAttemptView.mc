using Toybox.ActivityMonitor as Act;
using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.System as Sys;
using Toybox.Time.Gregorian as Calendar;
using Toybox.WatchUi as Ui;

class SecondAttemptView extends Ui.WatchFace {

	
    function initialize() {
        WatchFace.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get the current time and format it correctly
        var timeFormat = "0$1$:$2$";
        var timeFormat2 = "$1$:$2$";
        var dateInfo = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
        var clockTime = Sys.getClockTime();
        var hours = clockTime.hour;
        var timeString;
        System.println(clockTime.hour);
        //var meridian = "a.m.";
        if (!Sys.getDeviceSettings().is24Hour) {
            if (hours >= 12) {
                hours = hours - 12; 
                //meridian = "p.m.";
            }
            if (hours == 0) {
            	hours = 12;
            	}
        } else {
            if (App.getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        if ((hours == 10) || (hours == 11) || (hours == 12) || (hours == 22) || (hours == 23) || (hours == 24)) {
        timeString = Lang.format(timeFormat2, [hours, clockTime.min.format("%02d")]);
        System.println("2 digit numbers");
        } else {
        timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
        System.println("1 digit numbers");
        }
        var dayString = Lang.format("$1$ $2$", [dateInfo.month, dateInfo.day]);

        // Update the view
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
        var dateLabel = View.findDrawableById("DateLabel");
        dateLabel.setText(dayString);
        

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
