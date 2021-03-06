package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...sebita
 */
class CollisionStructure extends FlxSprite
{
	public var life:Int = 3;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);	
		loadGraphic(AssetPaths.wall__png, true, 12, 5);
		
		animation.add("pared1", [0], 8, false);
		animation.add("pared2", [1], 8, false);
		animation.add("pared3", [2], 8, false);
	}
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
	
	public function changeWall():Void {
		life--;
		switch(life) {
			case 2:
				animation.play("pared2");
			case 1:
				animation.play("pared3");
			case 0:
				destroy();
		}
	}
	
}