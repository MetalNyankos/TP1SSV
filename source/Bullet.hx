package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
/**
 * ...
 * @author ...jms
 */
class Bullet extends FlxSprite
{
	var bulletSpeed:Int = 300;
	public var activeBullet:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){ 
		super(x, y , SimpleGraphic);
		makeGraphic(3, 10, 0xff00ffff);
		velocity.y -= bulletSpeed;
		activeBullet = true;
	}
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		Destruction();
	}
	
	public function Destruction(){
		if(this.y<0){
			activeBullet=false;
			destroy();
		}
	}
}