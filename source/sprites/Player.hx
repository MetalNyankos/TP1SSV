package sprites;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import sprites.Bullet;
import flixel.system.FlxSound;
/**
 * ...
 * @author ...jms
 */
class Player extends FlxSprite
{
	public var speed:Int = Reg.playerSpeed;
	public var lives:Int = Reg.playerLives;
	public var bullet:Bullet;
	private var sceneBullet:Bool = false;
	private var bulletSound:FlxSound;
	public var spriteDestroyActive:Bool = false;
	public var checkSpriteDestroy:Int = 0;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) { 
		super(FlxG.width / 2, y, SimpleGraphic);
		loadGraphic("assets/images/player.png");
		y = FlxG.height - this.height;
		bullet = new Bullet(null, null, null, 300);
		bullet.kill();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (spriteDestroyActive) {
			checkSpriteDestroy--;
			if (checkSpriteDestroy == 0) {
				loadGraphic("assets/images/player.png");
				spriteDestroyActive = false;
			}
		}else {
			Movement();
		}
		
	}
	
	public function Movement():Void {
		if (FlxG.keys.pressed.LEFT && this.x > 0) {
			x -= speed;
		} else if(FlxG.keys.pressed.RIGHT && this.x < FlxG.width - this.width) {
			x += speed;	
		}
		
		if (FlxG.keys.justPressed.SPACE && !bullet.alive) {
			bullet.revive();
			bulletSound = FlxG.sound.load(AssetPaths.Laser__wav);
			bulletSound.play();
			bullet.x = this.x + width / 2 - bullet.width / 2;
			bullet.y = this.y;
			
			FlxG.state.add(bullet);
		}		
	}
	
	public function destroyBullet():Void{
		bullet.destroy();
	}
}