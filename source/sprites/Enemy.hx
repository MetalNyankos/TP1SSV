package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;
import flixel.FlxG;
import sprites.Bullet;
import flixel.system.FlxSound;
/**
 * TP1 SSV Desarrollo de videojuegos TN 2016
 * @author Maximiliano Viñas Craba
 */
class Enemy extends FlxSprite
{
	public var xStep:Int = Reg.invaderInitialXMoveRate;
	public var bullet:Bullet;
	public var pointValue:Int;
	public var status:Int = 0;
	public var changeSprite:Int = 0;
	public var enemySprite:Int;
	private var bulletSound:FlxSound;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, val:Int,sprite:Int) 
	{
		super(X, Y, SimpleGraphic);
		pointValue = val;
		enemySprite = sprite;
		switch(enemySprite){
			case 0:
				loadGraphic(AssetPaths.Enemy__png, true, 10, 8);
			case 1, 2:
				loadGraphic(AssetPaths.Enemy2__png, true, 10, 8);
			case 3,4:
				loadGraphic(AssetPaths.Enemy3__png, true, 10, 8);
		}
		animation.add("enemy1", [0], 8, false);
		animation.add("enemy2", [1], 8, false);
		bullet = new Bullet(null,null,null,-300);
		bullet.kill();
	}
	
	public function Move():Bool
	{
		var reachedBorder = false;
		
		if (((this.x + this.width) + xStep) > FlxG.width || (this.x + xStep) < 0)
		{
			reachedBorder = true;
			return reachedBorder;
		}
		
		this.x += xStep;
		//Reg.t.play();
		return reachedBorder;
	}
	
	public function ReachedEndOfScreen():Bool
	{
		var reachedEnd = false;
		
		if ((this.y - this.height) > (FlxG.height - 40) )
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
		bulletSound = FlxG.sound.load(AssetPaths.Laser__wav);
		bulletSound.play();
		bullet.x = this.x + width / 2 - bullet.width / 2;
		bullet.y = this.y;
		FlxG.state.add(bullet);
	}
	override public function update(elapsed:Float):Void
	{
		if (enemySprite != null) {
			changeSprite++;
			if (changeSprite == 30) {
				if (status == 0) {
					animation.play("enemy2");
					status = 1;
				} else {
					animation.play("enemy1");
					status = 0;
				}
				changeSprite = 0;
			}
		}
		
	}
}