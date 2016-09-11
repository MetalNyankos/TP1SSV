package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;
import flixel.FlxG;

/**
 * TP1 SSV Desarrollo de videojuegos TN 2016
 * @author Maximiliano Viñas Craba
 */
class Enemy extends FlxSprite
{
	//private x:int;
	//private y:int;
	private var xStep = 20;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 16);
	}
	
	public function move():Void
	{
		trace("xstep " + xStep);
		if ((this.x + 20) > FlxG.width || (this.x - 20) < 0)
		{
			this.y += 20;
			xStep *= -1;
		}

		this.x += xStep;
	}
	
}