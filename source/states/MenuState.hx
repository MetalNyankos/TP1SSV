package states;

import flash.display3D.textures.Texture;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import states.PlayState;
import states.GameOverState;
import flixel.system.FlxSound;

class MenuState extends FlxState
{	
	
	private var NameTxt:FlxText;
	private var instructionsTxt:FlxText;
	private var play:FlxButton;
	private var themeSong:FlxSound;

	override public function create():Void
	{		
		themeSong = FlxG.sound.load(AssetPaths.song__wav,1,true);
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		themeSong.play();
		super.create();
		NameTxt = new FlxText(20, 0, 0, "SPACE\nINVADERS\n", 20);
		NameTxt.alignment = CENTER;
		NameTxt.screenCenter(X);
		NameTxt.color = 0xff00ffff;
		add(NameTxt);
		
		instructionsTxt = new FlxText(0, 60, 0, "MOVE WITH THE ARROW KEYS\nFIRE WITH SPACEBAR\n", 8);
		instructionsTxt.alignment = CENTER;
		instructionsTxt.screenCenter(X);
		instructionsTxt.color = 0xff00ffff;
		add(instructionsTxt);

		play = new FlxButton(0, 0, "Play", Start);
		play.x = (FlxG.width / 2) - (play.width / 2);
		play.y = FlxG.height - play.height - 10;
		add(play);
	}
	
	public function Start():Void
	{
		remove(NameTxt);
		remove(instructionsTxt);
		remove(play);
		FlxG.switchState(new PlayState());
	}
	
	public function Splash()
	{
		var splash:FlxText = new FlxText(0,0,0,"SSV CREATIONS PRESENTS");
		splash.alignment = CENTER;
		splash.screenCenter(X);
		splash.color = 0xff00ffff;
		add(splash);
	}
}
