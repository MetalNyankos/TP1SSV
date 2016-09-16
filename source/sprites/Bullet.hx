package sprites;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
/**
 * ...
 * @author ...jms
 */
class Bullet extends FlxSprite
{
	public var bulletSpeed:Int = 300;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, ?auxSpeed:Int = 300){ 
		super(x, y , SimpleGraphic);
		makeGraphic(1, 3, 0xff00ffff);
		velocity.y -= auxSpeed;
	}
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		Destruction();
	}
	
	public function Destruction() {
		if(this.y + this.height < 0 || this.y + this.height > FlxG.height){
			kill();
		}
	}
}