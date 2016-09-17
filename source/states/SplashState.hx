package states;

import flash.display3D.textures.Texture;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import states.MenuState;

/**
 * ...
 * @author Maximiliano Viñas Craba
 */
class SplashState extends FlxState
{
	private	var splash:FlxText;
	private var splashTimer:FlxTimer;

	override public function create():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		super.create();
		splashTimer = new FlxTimer();
		splash = new FlxText(0, (FlxG.height / 2) - 10, 0, "SSV CREATIONS PRESENTS");
		splash.alignment = CENTER;
		splash.screenCenter(X);
		splash.color = 0xff00ffff;
		add(splash);
		splashTimer.start(3, GoToMenu, 1);
	}
	
	public function GoToMenu(Timer:FlxTimer):Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
		{
			FlxG.switchState(new MenuState());
		});
	}
	
}