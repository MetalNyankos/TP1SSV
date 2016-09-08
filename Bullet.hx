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
	var velocidadBala:Int = 500;
	public var balaActiva = false;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{ 
		super(x, y , SimpleGraphic);
	
		makeGraphic(4, 16, 0xff00ffff);
		
		velocity.y -= velocidadBala;
	
		balaActiva = true;
	}
	override public function update(elapsed:Float):Void
	{
	 
	super.update(elapsed);
	
	DestruccionObjeto();
	
	
	}
	
	
	public function DestruccionObjeto(){
	if(this.y<0){
		balaActiva=false;
		destroy();
	
	  }
	}
	

	
}