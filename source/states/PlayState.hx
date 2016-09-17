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
import sprites.SpecialEnemy;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
	private var invaders:FlxTypedGroup<Enemy>;
	private var collisionStructureGroup:FlxTypedGroup<CollisionStructure>;
	private var player:Player;
	private var specialEnemy:SpecialEnemy;
	private var scoreText :FlxText;
	private var highScoreText :FlxText;
	private var livesCounter :FlxText;
	private var movementTimer:FlxTimer;
	private var invaderFiringTimer:FlxTimer;
	private var victory:Bool = false;
	private var score:Int = 0;
	private var invaderMoveRate:Float = Reg.invaderInitialTimerMoveRate;
	private var checkTimeForSpecialEnemy:Int = 0;  
	private var playerDied:FlxSound;
	private var reachedBorder:Bool = false;
	private var moveSound:FlxSound;
	
	override public function create():Void
	{
		super.create();
		CreateInvaders();
		CreatePlayer();
		CreateStructures();
		CreateHeaders();
		InitializeTimers();
		moveSound = FlxG.sound.load(AssetPaths.enemyMovement__wav);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		checkTimeForSpecialEnemy++;
		if (checkTimeForSpecialEnemy == 400){
			CreateSpecialEnemy();
			checkTimeForSpecialEnemy = -350;
		}
		if (player.bullet.alive)
		{
			CheckPlayerBulletHit();
		}
		
		invaders.forEachAlive(CheckEnemyBulletHit);
	}
	
	public function CreateSpecialEnemy():Void{
		specialEnemy = new SpecialEnemy(1, 12, null, 1000,null);
		add(specialEnemy);
	}
	
	public function CreateHeaders()
	{
		scoreText = new FlxText(0, 0, null, "S: " + score);
		highScoreText = new FlxText(70, 0, null, "HS: " + Reg.highScore);
		livesCounter = new FlxText(140, 0, null, "L: " + player.lives);
		add(scoreText);
		add(highScoreText);
		add(livesCounter);
	}
	
	public function CreateInvaders():Void
	{
		invaders = new FlxTypedGroup<Enemy>();

		var x:Int = 20;
		var y:Int = 25;
		var pointValue = 500;
		
		for ( i in 0...5)
		{
			for (j in 0...8)
			{
				var invader:Enemy = new Enemy(x, y, null, pointValue,i);
				invaders.add(invader);
				x += 13;
			}
			x = 20;
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
		var x:Int = 11, y:Int = 112, structureCount = 1, structureCountGroup = 1;
		
		for (i in 0...18) {
			
			var cs:CollisionStructure = new CollisionStructure(x,y);
			collisionStructureGroup.add(cs);
			
			structureCount++;
			x += 12;
			
			if (structureCount == 4) {
				structureCountGroup++;
				structureCount = 1;
				x += 15;
			}
			if(structureCountGroup == 4){
				y += 5;
				x = 11;
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
		highScoreText.text = "HS: " + Reg.highScore;
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
		moveSound.play();
	}
	
	public function _MoveInvaders(invader:Enemy):Void
	{
		if (reachedBorder)
		{
			invaders.forEachAlive(MoveDownwards);
			CorrectFirstRow();
		}
		
		reachedBorder = invader.Move();
		
		if (invader.ReachedEndOfScreen())
		{
			victory = false;
			GameOver();
		}
	}
	 
	public function MoveDownwards(invader:Enemy):Void
	{
		invader.MoveDownwards();
	}
	
	public function CorrectFirstRow():Void
	{
		for (i in 0...8)
		{
			if (invaders.members[i].xStep == 1)
			{
				invaders.members[i].x += 1;
			}
			else
			{
				invaders.members[i].x -= 1;
			}
		}
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
		
		if (FlxG.overlap(player.bullet, specialEnemy)) {
			playerDied = FlxG.sound.load(AssetPaths.Explosion__wav);
			playerDied.play();
			player.bullet.kill();
			score += specialEnemy.pointValue;
			UpdateScore();

			if (score > Reg.highScore){
				Reg.highScore = score;
				UpdateHighScore();
			}
			specialEnemy.destroy();
		  }
		
		for (i in 0...invaders.length) 
		{
			if(invaders.members[i].alive){
				if (FlxG.pixelPerfectOverlap(player.bullet, invaders.members[i])) {
					playerDied = FlxG.sound.load(AssetPaths.Explosion__wav);
					playerDied.play();
					player.bullet.kill();
					score += invaders.members[i].pointValue;
					UpdateScore();

					if (score > Reg.highScore)
					{
						Reg.highScore = score;
						UpdateHighScore();
					}
					
					invaders.members[i].kill();
					
					if (invaders.countLiving() % 10 == 0)
					{
						movementTimer.time /= 2;
					}		
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
			player.spriteDestroyActive = true;
			player.loadGraphic("assets/images/explosion.png");
			player.checkSpriteDestroy = 100;
			playerDied = FlxG.sound.load(AssetPaths.Explosion__wav);
			playerDied.play();
			if (player.lives > 0)
			{
				player.lives--;
				UpdateLiveCounter();
			}
			else
			{
				player.kill();
				victory = false;
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
		
		FlxG.switchState(new GameOverState(victory,score));
	}
}
