package;

//import sys.io.File;
//import sys.FileSystem;
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
import flixel.util.FlxTimer;
import flixel.util.FlxRandom;

class DeathState extends FlxState
{
    var score:Int;
    var deathText:FlxText;
    var scoreText:FlxText;
    var retryText:FlxText;

    public function new(score:Int):Void {
        super();
        this.score = score;
    }

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
        FlxG.sound.play("assets/sounds/Explosion13.wav", 1.0);
        var highScore = 0;
        /*
        if(FileSystem.exists("highscores.txt")) {
            var content = File.getContent("highscores.txt");
            highScore = Std.parseInt(content);
        }
        */
        bgColor = 0xff000000;
        retryText = new FlxText(FlxG.width/2-150, FlxG.height/2 - 100, 800, "You have died", 32);
        add(retryText);
        scoreText = new FlxText(FlxG.width/2-40, FlxG.height/2, 200, "Score: " + score, 16);
        add(scoreText);
        /*
        if(score > highScore) {
            var newHighScoreText = new FlxText(FlxG.width/2-80, FlxG.height/2+50, 200, "NEW HIGHSCORE!", 16);
            add(newHighScoreText);
            File.saveContent("highscores.txt", "" + score);
            highScore = score;
        }
        var highScoreText = new FlxText(FlxG.width/2-70, FlxG.height/2+100, 200, "Highscore : "+ highScore, 16);
        add(highScoreText);
        */
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
        if (FlxG.keys.pressed.SPACE) {
            FlxG.switchState(new MenuState());
        }
    }	
}
