package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
    override public function create():Void {
        super.create();
        var title = new FlxSprite(0, 0, "assets/images/title.png");
        add(title);
    }

    override public function update():Void {
        super.update();
        if(FlxG.keys.justPressed.SPACE) {
            FlxG.switchState(new PlayState());
        }
    }
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}
}
