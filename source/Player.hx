import flixel.FlxG;           
import flixel.group.FlxGroup; 
import flixel.util.FlxPoint;
import flixel.FlxSprite;      

class Player extends FlxSprite {
    public var cameraSprite:FlxSprite;

    public function new(x,y) {
        super(x, y);
        this.loadGraphic("assets/images/cat.png", true, 55, 48);
        //this.offset.x += this.width*0.25;
        this.height *= 0.9;
        this.width *= 0.9;
        this.cameraSprite = new FlxSprite();
        this.cameraSprite.y = y-80;
        this.animation.add("walk", [0, 1], 10, true);
        this.animation.add("jump", [2], 10, true);
        this.animation.play("walk");
    }

    override public function update():Void {
        super.update();       
        if(this.y < -43) {
            this.animation.play("jump");
        } else {
            if(animation.name == "jump") {
                this.animation.play("walk");
            }
        }
        this.cameraSprite.x = x+200;
    }
}
