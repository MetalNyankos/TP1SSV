//package states;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import states.MenuState;
class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(160, 144, MenuState, 3));
	}
}
