package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.FlxCamera;
import flixel.util.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxTimer;
import flixel.util.FlxRandom;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
    var player:Player;
    private var jumpVelocity:Float = -1200;
    public var ground:FlxObject;
    public var platform:FlxObject;
    var specialBadGuy :FlxSprite;
    //groups
    public var enemies:FlxGroup;
    public var enemies2:FlxGroup;
    public var spikeEnemies:FlxGroup;
    public var myPlatforms:FlxGroup;
    var enemyX:Float;
    var enemyY:Float;
    var enemyVel:Float = 450;
    private var music:FlxSound;

    //score
    var score:Int;
    var scoreText:FlxText;

    //music
    var musicLoops : Int = 1;
    var musicLoopsSoFar : Int = 0;
    var musicTrack : Int = 0;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
        //bgColor = 0xffaaaaaa;
        bgColor = 0xffb2eeff;
        player = new Player(0, -100);
        //player.velocity.x = 30;
        player.acceleration.y = 4400;
        ground = new FlxSprite(-120, 0, "assets/images/ground.png");
        // Make it able to collide, and make sure it's not tossed around
        ground.solid = ground.immovable = true;
        add(ground);

        var timer = new FlxTimer(1.0, generateEnemy, 1);
        var timer = new FlxTimer(0.3, addToScore, 1);
        var timer = new FlxTimer(1.0, generateCloud, 1);
        //add(timer);
        //enemies 
        myPlatforms = new FlxGroup();
        add(myPlatforms);
        enemies = new FlxGroup();
        enemies2 = new FlxGroup();
        spikeEnemies = new FlxGroup();
        enemyX = 600;
        enemyY = player.y + 36;
        add(enemies);
        add(enemies2);

        //spikes
        add(spikeEnemies);
        FlxG.camera.follow(player.cameraSprite);
        add(player);
        score = 0;
        scoreText = new FlxText(0, 0, 200, "Score: " + score, 16);
        //scoreText.text = "Score: " + score;
        add(scoreText);

        //platforms

        //music
        music = null;
        if(FlxG.sound.music != null) {
            FlxG.sound.music.stop();
        }
        FlxG.sound.playMusic("assets/music/music_0_edit.wav", 0.7, false);
        FlxG.sound.music.onComplete = onMusComplete;
        
	}

    public function onMusComplete() : Void {
        if(musicLoopsSoFar > musicLoops) {
            musicLoopsSoFar = 0;
            musicTrack++;
            if(musicTrack > 6) {
                musicTrack = 6;
            }
        }
        var sound = FlxG.sound.play("assets/music/music_" + musicTrack + "_edit.wav", 0.7);
        sound.onComplete = onMusComplete;
        musicLoopsSoFar++;
    }

	public function addToScore(timer:FlxTimer):Void {
        score += 1;
        var timer = new FlxTimer(0.1, addToScore, 1);
        scoreText.text = "Score: " + score;
    }

	public function generateCloud(timer:FlxTimer):Void {
        var cloud :FlxSprite = new FlxSprite(enemyX, enemyY-300, "assets/images/cloud.png");
        cloud.velocity.x -= enemyVel/2;
        add(cloud);

        var timer = new FlxTimer(3.0, generateCloud, 1);
    }

	public function generateEnemy(timer:FlxTimer):Void {
        //var choice = FlxRandom.intRanged(0, 2);
        var choice = 2;
        if(choice == 0) {
            var badGuy :FlxSprite = new FlxSprite(enemyX, enemyY, "assets/images/badguy.png");
            badGuy.velocity.x -= enemyVel;
            enemies.add(badGuy);
        } else if(choice == 1) {
            var spike : FlxSprite = new FlxSprite(enemyX, enemyY, "assets/images/spikewall.png");
            spike.velocity.x -= enemyVel;
            spikeEnemies.add(spike);
        } else if(choice == 2) {
            /*
            var badGuy :FlxSprite= new FlxSprite(enemyX, enemyY, "assets/images/badguy2.png");
            badGuy.velocity.x -= enemyVel;
            enemies2.add(badGuy);
            */
            //var badGuy :FlxSprite= new FlxSprite(enemyX, enemyY-150, "assets/images/badguy2.png");
            specialBadGuy = new FlxSprite(enemyX, enemyY-200, "assets/images/badguy2.png");
            specialBadGuy.velocity.x -= enemyVel;
            specialBadGuy.velocity.y = 100;
            enemies2.add(specialBadGuy);

            /*
            var badGuy :FlxSprite = new FlxSprite(enemyX, enemyY-100, "assets/images/badguy2.png");
            badGuy.velocity.x -= enemyVel;
            enemies.add(badGuy);
            */

            /*
            //var badGuy :FlxSprite = new FlxSprite(enemyX, enemyY-10, "assets/images/platform.png");
            var badGuy :FlxSprite = new FlxSprite(enemyX, enemyY-9, "assets/images/platform.png");
            badGuy.velocity.x -= enemyVel;
            badGuy.solid = badGuy.immovable = true;
            platform = badGuy;
            */
            
            /*
            badGuy.allowCollisions = FlxObject.ANY;
            badGuy.allowCollisions |= FlxObject.UP;
            badGuy.allowCollisions |= FlxObject.RIGHT;
            badGuy.allowCollisions |= FlxObject.LEFT;
            badGuy.allowCollisions |= FlxObject.DOWN;
            */
            //enemies.add(badGuy);
            //add(badGuy);
            //myPlatforms.add(badGuy);
            /*

            var myPlatform = new FlxSprite(enemyX - 150, enemyY - 50, "assets/images/platform.png");
            myPlatform.velocity.x -= enemyVel;
            //platform.solid = platform.immovable = true;
            //platforms.add(platform);
            myPlatforms.add(myPlatform);
            */
        } else if(choice == 3) {
            var spike : FlxSprite = new FlxSprite(enemyX, enemyY, "assets/images/spikes_long.png");
            spike.velocity.x -= enemyVel;
            spikeEnemies.add(spike);
        } else if(choice == 4) {
            var spike : FlxSprite = new FlxSprite(enemyX, enemyY, "assets/images/spikes_longest.png");
            spike.velocity.x -= enemyVel;
            spikeEnemies.add(spike);
        }
        var timer = new FlxTimer(4.0, generateEnemy, 1);
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
        if (FlxG.keys.pressed.SPACE && player.isTouching(FlxObject.FLOOR)) {
            player.velocity.y = jumpVelocity;
            FlxG.sound.play("assets/sounds/Jump6.wav", 1.0);
        }
        FlxG.overlap(enemies, player, collideEnemy, pixelPerfectProcess);
        FlxG.overlap(enemies2, player, collideEnemy, pixelPerfectProcess);
        FlxG.overlap(spikeEnemies, player, collideSpikeEnemy, pixelPerfectProcess);
        //FlxG.overlap(myPlatforms, player, collidePlatforms, pixelPerfectProcess);
        //FlxG.collide(player, myPlatforms);
        FlxG.collide(player, platform);
        if(specialBadGuy != null && specialBadGuy.alive) {
            if( ((player.x - specialBadGuy.x) * (player.x - specialBadGuy.x)
 + (player.y - specialBadGuy.y) * (player.y - specialBadGuy.y)) < 5000) {
                collideEnemy(specialBadGuy, player);
            }
        }
    }	

    public function collidePlatforms(enemy:FlxObject, player:FlxObject):Void {
        FlxG.switchState(new DeathState(score));
    }

    public function collideSpikeEnemy(enemy:FlxObject, player:FlxObject):Void {
        FlxG.switchState(new DeathState(score));
    }

    public function collideEnemy(enemy:FlxObject, player:FlxObject):Void {
        //TODO: Add fancy animation + scoring
        enemy.kill();
        score += 100;
        scoreText.text = "Score: " + score;
        FlxG.sound.play("assets/sounds/Pickup_Coin15.wav", 1.0);
        var explosion = new Explosion(enemy.x, enemy.y);
        add(explosion);
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
