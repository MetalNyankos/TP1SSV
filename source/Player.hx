package;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import Bullet;
/**
 * ...
 * @author ...jms
 */
class Player extends FlxSprite
{
	public var speed :Int= 3;
	public var life:Int = 3;
	public var bullet:Bullet;
	private var sceneBullet:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) { 
		super(FlxG.width/2, y, SimpleGraphic);
		makeGraphic(10, 10, 0xff00ff00);
		y = FlxG.height - this.height;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		Movement();
	}
	
	public function Movement():Void{
		if (FlxG.keys.pressed.LEFT&&this.x>0){
			x-= speed;
		} else if(FlxG.keys.pressed.RIGHT&&this.x<FlxG.width-this.width) {
			x += speed;	
		}
		
		if (FlxG.keys.justPressed.SPACE && sceneBullet == false ){
			bullet = new Bullet();
			bullet.x = this.x+width/2-bullet.width/2;
			bullet.y = this.y;
		
			FlxG.state.add(bullet);
		}
		if(bullet!=null){	
			sceneBullet = bullet.activeBullet;
			//verifica si el booleano de la clase bullet esta activo, 
			//mientra haya sido creada la clase respectiva 
		}
		
	}
	
	public function getBullet():Bullet
	{
		return bullet;
	}
	
	public function destroyBullet():Void{
		if (bullet != null) {
			bullet.activeBullet = false;
			bullet.destroy();
		}
	}
}