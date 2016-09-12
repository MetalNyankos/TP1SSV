package sprites;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import sprites.Bullet;
/**
 * ...
 * @author ...jms
 */
class Player extends FlxSprite
{
	public var speed:Int = 3;
	public var lives:Int = 3;
	public var bullet:Bullet;
	private var sceneBullet:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) { 
		super(FlxG.width / 2, y, SimpleGraphic);
		makeGraphic(10, 10, 0xff00ff00);
		y = FlxG.height - this.height;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		Movement();
	}
	
	public function Movement():Void {
		if (FlxG.keys.pressed.LEFT && this.x > 0) {
			x -= speed;
		} else if(FlxG.keys.pressed.RIGHT && this.x < FlxG.width - this.width) {
			x += speed;	
		}
		
		if (FlxG.keys.justPressed.SPACE && sceneBullet == false ) {
			bullet = new Bullet(null,null,null,300);
			bullet.x = this.x + width / 2 - bullet.width / 2;
			bullet.y = this.y;
		
			FlxG.state.add(bullet);
		}
		
		if(bullet != null) {	
			sceneBullet = bullet.isActive;
		}
		
	}
	
	public function GetBullet():Bullet
	{
		return bullet;
	}
	
	public function destroyBullet():Void{
		if (bullet != null) {
			bullet.isActive = false;
			bullet.destroy();
		}
	}
}