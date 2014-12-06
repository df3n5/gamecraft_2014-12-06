package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.util.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
    var player:Player;
    private var jumpVelocity:Float = -400;
    public var ground:FlxObject;
    var badGuy:FlxSprite;
    //groups
    public var enemies:FlxGroup;
    public var spikeEnemies:FlxGroup;
    var enemyX:Float;
    var enemyY:Float;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
        bgColor = 0xffaaaaaa;
        player = new Player(0, -100);
        //player.velocity.x = 30;
        player.acceleration.y = 700;
        ground = new FlxSprite(-120, 0, "assets/images/ground.png");
        // Make it able to collide, and make sure it's not tossed around
        ground.solid = ground.immovable = true;
        add(ground);

        //enemies 
        enemies = new FlxGroup();
        spikeEnemies = new FlxGroup();
        enemyX = 200;
        enemyY = player.y + 36;
        badGuy = new FlxSprite(enemyX, enemyY, "assets/images/badguy.png");
        badGuy.velocity.x -= 50;
        enemies.add(badGuy);
        add(enemies);

        //spikes
        var spike : FlxSprite = new FlxSprite(enemyX+100, enemyY, "assets/images/spikewall.png");
        spike.velocity.x -= 50;
        spikeEnemies.add(spike);
        add(spikeEnemies);

        add(badGuy);
        FlxG.camera.follow(player.cameraSprite);
        add(player);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
        //FlxG.camera.setPosition(player.x-FlxG.width, player.y-FlxG.height);
        /*
        FlxG.camera.x = player.x;
        FlxG.camera.y = player.y;
        */
        //ground.x = player.x-100;
        FlxG.collide(player, ground);
        if (FlxG.keys.pressed.W && player.isTouching(FlxObject.FLOOR)) {
            player.velocity.y = jumpVelocity;
        }
        FlxG.overlap(enemies, player, collideEnemy, pixelPerfectProcess);
        FlxG.overlap(spikeEnemies, player, collideSpikeEnemy, pixelPerfectProcess);
    }	


    public function collideSpikeEnemy(enemy:FlxObject, player:FlxObject):Void {
        FlxG.switchState(new PlayState());
    }

    public function collideEnemy(enemy:FlxObject, player:FlxObject):Void {
        //TODO: Add fancy animation + scoring
        enemy.kill();
    }

    private function pixelPerfectProcess(officer:FlxObject, bullet:FlxObject):Bool {
        var castBullet:FlxSprite = cast(bullet, FlxSprite);
        var castOfficer:FlxSprite = cast(officer, FlxSprite);
        if(FlxG.pixelPerfectOverlap(castBullet, castOfficer)) {
            return true;
        }
        return false;
    }
}
