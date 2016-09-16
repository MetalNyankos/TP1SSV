package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...sebita
 */
class SpecialEnemy extends Enemy
{
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset, val:Int, sprite:Int ) 
	{
		super(X, Y, SimpleGraphic,val,sprite);
		loadGraphic(AssetPaths.SpecialEnemy__png, true, 22, 10);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (this.x < 160){
			this.x++;
		} else {
			this.destroy();
		}
		
	}
}