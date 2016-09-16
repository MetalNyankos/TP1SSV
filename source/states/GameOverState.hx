package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import states.PlayState;

/**
 * 
 * @author Maximiliano Viñas Craba
 */

class GameOverState extends FlxState
{

	override public function create():Void
	{
		super.create();
		var test:FlxText = new FlxText(0, 0, 0, "Test");
		add(test);
	}
	
}