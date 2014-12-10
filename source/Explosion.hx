import flixel.FlxG;           
import flixel.group.FlxGroup; 
import flixel.util.FlxPoint;
import flixel.FlxSprite;      

class Explosion extends FlxSprite {

    public function new(x,y) {
        super(x, y);
        this.loadGraphic("assets/images/explosion.png", true, 64, 64);
        this.animation.add("explosion", [0, 1, 2, 3], 20, false);
        this.animation.play("explosion");
    }

    override public function update():Void {
        super.update();       
        if(this.animation.finished) {
            kill();
        }
    }
}
