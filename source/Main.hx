//package states;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import states.SplashState;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(160, 144, SplashState, 3));
	}
}
