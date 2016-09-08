package;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
/**
 * ...
 * @author ...jms
 */
class Player extends FlxSprite
{
	public var velocidad :Int= 5;
	public var vidas:Int = 3;
	public var copiaBala:Bullet;
	private var balaEscena:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{ 
	//z	var posy = FlxG.height - this.height;
		super(FlxG.width/2, y, SimpleGraphic);

	//	y = FlxG.height - this.height;		
	
		makeGraphic(40, 40, 0xff00ff00);
		y = FlxG.height - this.height;
	}

	override public function update(elapsed:Float):Void
	{
	 
		super.update(elapsed);
     Teclas();
		//super.update(elapsed);
	}
	

	public function Teclas():Void{
		trace(copiaBala);
		if (FlxG.keys.pressed.LEFT&&this.x>0){
			
		x-= velocidad;
			
		}else if(FlxG.keys.pressed.RIGHT&&this.x<FlxG.width-this.width){
		x += velocidad;	
		}
		
		if (FlxG.keys.justPressed.SPACE && balaEscena == false ){
	

		
		copiaBala = new Bullet();
		copiaBala.x = this.x+width/2-copiaBala.width/2;
		copiaBala.y = this.y;
		
		
		FlxG.state.add(copiaBala);
			
		}
	if(copiaBala!=null){	
		balaEscena = copiaBala.balaActiva;//verifica si el booleano de la clase bullet esta activo, mientra haya sido creada la clase respectiva 
	}
		
	}

	
}