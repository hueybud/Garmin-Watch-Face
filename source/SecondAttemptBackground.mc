using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.ActivityMonitor as Act;

class Background extends Ui.Drawable {
	
	var background;
	var bgcolor;
	var color;
	var background2;
	var background3;
	var check;
	var batteryLife;
	var steps;
	var steps2;
	var goal;
	var goal2;
	var steps3;
	var steps4;
	var steps5;
	var steps6;
	
		
    function initialize(params) {
    	// Read in parameters
    	if (params == null) { 
    		params = {}; 
    		color = Gfx.COLOR_PURPLE;
    	} else {
    		bgcolor = params.get(:bgcolor);
    	}
        Drawable.initialize(params);
        // Load Resources
        background = Ui.loadResource(Rez.Drawables.id_background);
        background2 = Ui.loadResource(Rez.Drawables.id_background2);
        background3 = Ui.loadResource(Rez.Drawables.id_background3);
        if (check == null) {
        check=0;
        }
		steps = Act.getInfo().steps;
		steps2 = steps.toDouble();
		goal = Act.getInfo().stepGoal;
		goal2 = goal.toDouble();
        if (steps2 >= goal2) {
		goal2 = goal2 * 100;
		check = check +1;
		}
		steps3 = (steps2 / goal2) * 100;
		steps4 = steps3.toNumber();
		steps5 = -1.48*steps4 + 180;
		steps6 = steps5.toNumber();
		
		batteryLife = Sys.getSystemStats().battery;
		batteryLife = -1.48*batteryLife + 180;
		batteryLife = batteryLife.toNumber();
        System.println(batteryLife);
        System.println(steps4);
		
        
        
        
    }

    function draw(dc) {
    	dc.clear();
    	// Draw Background Color
    	dc.setColor(bgcolor, Gfx.COLOR_TRANSPARENT);
    	dc.fillRectangle(0,0,dc.getWidth(),dc.getHeight());
    	// Draw Background
        dc.drawBitmap(69,75,background);
		// Draw the power bar and step count bar
        dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
        dc.drawRectangle(37, 32, 13, dc.getHeight()-32);
        dc.drawRectangle(165, 32, 13, dc.getHeight()-32);
        dc.drawBitmap(163,12,background2);
        dc.drawBitmap(35, 10, background3);
        System.println(batteryLife);
        System.println(dc.getHeight());
        if (batteryLife > 165) {
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        } else {
        dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
        }
        dc.fillRectangle(37, batteryLife , 13, 148);
        if (steps6 < 47) {
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
        } else {
        dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
        }
        if (check >=1) {
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
        }
        dc.fillRectangle(165, steps6, 13, 148);
        
 
    }
}