package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import sprites.Enemy;
import sprites.Player;
import sprites.CollisionStructure;
import sprites.Bullet;
import states.GameOverState;

class PlayState extends FlxState
{
	private var invaders:FlxTypedGroup<Enemy>;
	private var collisionStructureGroup:FlxTypedGroup<CollisionStructure>;
	private var player:Player;
	private var scoreText :FlxText;
	private var highScoreText :FlxText;
	private var livesCounter :FlxText;
	private var movementTimer:FlxTimer;
	private var invaderFiringTimer:FlxTimer;
	private var victory:Bool = false;
	private var lost:Bool = false;
	private var score:Int = 0;
	private var highscore:Int = 0;
	private var invaderMoveRate:Float = 0.5;
	
	override public function create():Void
	{
		super.create();
		CreateInvaders();
		CreatePlayer();
		CreateStructures();
		CreateHeaders();
		InitializeTimers();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (!victory || !lost)
		{
			if (player.bullet.alive)
			{
				CheckPlayerBulletHit();
			}
			
			invaders.forEachAlive(CheckEnemyBulletHit);
		}	
	}
	
	public function CreateHeaders()
	{
		scoreText = new FlxText(0, 0, null, "S: " + score);
		highScoreText = new FlxText(70, 0, null, "HS: " + highscore);
		livesCounter = new FlxText(140, 0, null, "L: " + player.lives);
		add(scoreText);
		add(highScoreText);
		add(livesCounter);
	}
	
	public function CreateInvaders():Void
	{
		invaders = new FlxTypedGroup<Enemy>();

		var x:Int = 40;
		var y:Int = 15;
		var pointValue = 500;
		
		for ( i in 0...5)
		{
			for (j in 0...10)
			{
				var invader:Enemy = new Enemy(x, y, null, pointValue);
				invaders.add(invader);
				x += 10;
			}
			x = 40;
			y += 10;
			pointValue -= 100;
		}
		
		add(invaders);

	}
	
	public function CreatePlayer()
	{
		player = new Player((FlxG.width / 2), FlxG.height - 20);
		add(player);
	}
	
	public function CreateStructures()
	{
		collisionStructureGroup = new FlxTypedGroup<CollisionStructure>();	
		var x:Int = 12, y:Int = 100, structureCount = 1, structureCountGroup = 1;
		
		for (i in 0...18) {
			
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
		add(collisionStructureGroup);
	}
	
	public function UpdateScore():Void
	{
		scoreText.text = "S: " + score;
	}
	
	public function UpdateHighScore():Void
	{
		highScoreText.text = "HS: " + highscore;
	}
	
	public function UpdateLiveCounter():Void
	{
		livesCounter.text = "L: " + player.lives;
	}
	
	public function InitializeTimers()
	{
		movementTimer = new FlxTimer();
		invaderFiringTimer = new FlxTimer();
		movementTimer.start(invaderMoveRate, MoveInvaders, 0);
		invaderFiringTimer.start(3, InvaderFires, 0);
	}
	
	public function MoveInvaders(Timer:FlxTimer):Void
	{
		invaders.forEachAlive(_MoveInvaders);
	}
	
	public function _MoveInvaders(invader:Enemy):Void
	{
		var reachedBorder:Bool = false;
		
		reachedBorder = invader.Move();
			
		if (reachedBorder)
		{
			invaders.forEachAlive(MoveDownwards);
		}
		
		if (invader.ReachedEndOfScreen())
		{
			lost = true;
			GameOver();
		}
	}
	 
	public function MoveDownwards(invader:Enemy):Void
	{
		invader.MoveDownwards();
	}
	
	public function InvaderFires(Timer:FlxTimer):Void
	{
		if(!victory)
		{
			var rnd:FlxRandom = new FlxRandom();
			var rndInvader:Int = rnd.int(0, invaders.length - 1);
			var canFire:Bool = invaders.members[rndInvader].alive;

			while (!canFire)
			{
				rndInvader = rnd.int(0, invaders.length - 1);
				canFire = invaders.members[rndInvader].alive;
			}
			
			invaders.members[rndInvader].Fire();
		}
	}
	
	public function CheckPlayerBulletHit():Void
	{
		CheckStructureHit(player.bullet);
		for (i in 0...invaders.length) 
		{
			if (FlxG.overlap(player.bullet, invaders.members[i])) {
				player.bullet.kill();
				score += invaders.members[i].pointValue;
				UpdateScore();

				if (score > highscore)
				{
					highscore = score;
					UpdateHighScore();
				}
				
				invaders.members[i].kill();
				
				if (invaders.countLiving() % 10 == 0)
				{
					movementTimer.time /= 2;
				}
				
			}
		}
		
		if (invaders.countLiving() == 0)
		{
			victory = true;
			GameOver();
		}
	}
	
	public function CheckEnemyBulletHit(invader:Enemy):Void
	{
		CheckStructureHit(invader.bullet);
		if (FlxG.overlap(invader.bullet, player)) {
			invader.bullet.kill();
			if (player.lives > 0)
			{
				player.lives--;
				UpdateLiveCounter();
			}
			else
			{
				player.kill();
				GameOver();
			}
		}
	}
	
	public function CheckStructureHit(bullet:Bullet):Void
	{
		for (i in 0...collisionStructureGroup.length) {
			if (bullet != null){
				if (FlxG.overlap(bullet, collisionStructureGroup.members[i])) {
					bullet.kill();
					collisionStructureGroup.members[i].changeWall();
				}
			}
		}
	}
	
	public function GameOver():Void
	{
		remove(player);
		player.destroyBullet();
		player.destroy();
		
		remove(invaders);
		for (i in 0...invaders.length)
		{
			invaders.members[i].destroyBullet();
			invaders.members[i].destroy();
		}
		
		remove(collisionStructureGroup);
		for (i in 0...collisionStructureGroup.length) {
			collisionStructureGroup.members[i].destroy();
		}
	
		scoreText.destroy();
		highScoreText.destroy();
		livesCounter.destroy();
		
		FlxG.switchState(new GameOverState());
	}
}
