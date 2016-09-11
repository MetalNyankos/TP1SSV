package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.group.FlxGroup;
import Player;
import CollisionStructure;

class PlayState extends FlxState
{
	private var collisionStructureGroup:FlxTypedGroup<CollisionStructure>;
	private var player:Player;
	
	override public function create():Void
	{
		super.create();
		
		collisionStructureGroup = new FlxTypedGroup<CollisionStructure>();	
		player = new Player();
		var x:Int = 12, y:Int = 100, structureCount = 1, structureCountGroup = 1;
		
		for (i in 0...18) { //DIBUJO DE LAS ESTRUCTURAS COLISIONABLES
			
			var cs:CollisionStructure = new CollisionStructure(x,y);
			collisionStructureGroup.add(cs);
			
			structureCount++;
			x += 10;
			
			if (structureCount == 4) {
				structureCountGroup++;
				structureCount = 1;
				x += 20;
			}
			if(structureCountGroup == 4){
				y += 5;
				x = 12;
				structureCount = 1;
				structureCountGroup = 1;
			}
		}
		
		add(player);
		add(collisionStructureGroup);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		for (i in 0...collisionStructureGroup.length) {
			if (player.getBullet() != null){
				if (FlxG.overlap(player.getBullet(), collisionStructureGroup.members[i])) {
					player.destroyBullet();
					collisionStructureGroup.members[i].changeWall();
				}
			}
		}
	}
}
