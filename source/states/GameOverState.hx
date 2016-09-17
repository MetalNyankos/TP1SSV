package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import states.PlayState;
import flixel.system.FlxSound;

/**
 * 
 * @author Maximiliano Viñas Craba
 */

class GameOverState extends FlxState
{	
	private var gameOver:FlxText;	
	private var scoreTxt:FlxText;
	private var highScoreTxt:FlxText;
	private var messageTxt:FlxText;
	private var replay:FlxButton;
	private var _score:Int;
	private var _victory:Bool;
	private var themeSong:FlxSound;
	
	public function new(victory:Bool, score:Int) 
	{
		_victory = victory;
		_score = score;
		super();
	}
	
	override public function create():Void
	{
		super.create();
		
		themeSong = FlxG.sound.load(AssetPaths.song__wav, 1, true);
		themeSong.play();
		gameOver = new FlxText(20, 0, 0, "GAME\nOVER\n", 20);
		gameOver.alignment = CENTER;
		gameOver.screenCenter(X);
		gameOver.color = 0xff00ffff;
		add(gameOver);
		
		messageTxt = new FlxText(0, 50, 0, null, 12);
		
		if (_victory)
		{
			messageTxt.text = "YOU WIN!";
		}
		else
		{
			messageTxt.text = "YOU LOST!";
		}
		
		messageTxt.alignment = CENTER;
		messageTxt.screenCenter(X);
		messageTxt.color = 0xff00ffff;
		add(messageTxt);
		
		scoreTxt = new FlxText(0, 70, 0, "Score : " + _score, 12);
		scoreTxt.alignment = CENTER;
		scoreTxt.screenCenter(X);
		scoreTxt.color = 0xff00ffff;
		add(scoreTxt);
		
		highScoreTxt = new FlxText(0, 85, 0, "Highscore : " + Reg.highScore , 12);
		highScoreTxt.alignment = CENTER;
		highScoreTxt.screenCenter(X);
		highScoreTxt.color = 0xff00ffff;
		add(highScoreTxt);

		replay = new FlxButton(0, 0, "Replay", Restart);
		replay.x = (FlxG.width / 2) - (replay.width / 2);
		replay.y = FlxG.height - replay.height - 10;
		add(replay);
	}
	
	private function Restart():Void
	{
		remove(gameOver);
		remove(messageTxt);
		remove(scoreTxt);
		remove(highScoreTxt);
		remove(replay);
		FlxG.switchState(new PlayState());
	}
}