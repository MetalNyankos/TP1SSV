package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;
import flixel.FlxG;
import sprites.Bullet;
/**
 * TP1 SSV Desarrollo de videojuegos TN 2016
 * @author Maximiliano Viñas Craba
 */
class Enemy extends FlxSprite
{
	public var xStep:Int = 1;
	public var bullet:Bullet;
	public var pointValue:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, val:Int) 
	{
		super(X, Y, SimpleGraphic);
		pointValue = val;
		makeGraphic(5, 5);
		bullet = new Bullet(null,null,null,-300);
		bullet.kill();
	}
	
	public function Move():Bool
	{
		var reachedBorder = false;
		
		this.x += xStep;
		
		if (((this.x + this.width) + xStep) > FlxG.width || (this.x + xStep) < 0)
		{
			reachedBorder = true;
		}
		
		return reachedBorder;
	}
	
	public function ReachedEndOfScreen():Bool
	{
		var reachedEnd = false;
		
		if ((this.y - this.height) > (FlxG.height - 20) )
		{
			reachedEnd = true;
		}
		
		return reachedEnd;
	}
	
	public function MoveDownwards():Void
	{
		this.y += width;
		xStep *= -1;
	}
	
	public function destroyBullet():Void{
		bullet.destroy();
	}
	
	public function Fire():Void
	{
		bullet.revive();
		bullet.x = this.x + width / 2 - bullet.width / 2;
		bullet.y = this.y;
		FlxG.state.add(bullet);
	}
	
}