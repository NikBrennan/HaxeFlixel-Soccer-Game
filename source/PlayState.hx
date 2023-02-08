package;

import Balls.Ball;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var background:FlxSprite;
	var grpWalls:FlxTypedGroup<FlxSprite>;
	var grpGoalStates:FlxTypedGroup<FlxSprite>;
	var ball:Ball;
	var net:Net;
	var goalie:Goalie;
	var score:Int = 0;
	var lives:Int = 3;
	var livesText:FlxText;
	var scoreText:FlxText;
	var gameover:Bool = false;

	override public function create()
	{
		// Load the background
		background = new FlxSprite();
		background.loadGraphic("assets/images/background.jpg");
		background.antialiasing = true;
		background.setGraphicSize(FlxG.width, FlxG.height);
		background.updateHitbox();
		add(background);

		// Create a net
		net = new Net();
		net.init();
		add(net);

		// Load the goalie
		goalie = new Goalie();
		goalie.init();
		add(goalie);

		grpGoalStates = new FlxTypedGroup<FlxSprite>();
		grpGoalStates.add(goalie);
		grpGoalStates.add(net);

		// Create the walls to keep goalie in net
		grpWalls = new FlxTypedGroup<FlxSprite>();
		var leftWall = wall(400, 200, 4, 400);
		var rightWall = wall(996, 200, 4, 400);
		grpWalls.add(leftWall);
		grpWalls.add(rightWall);
		// Make all the walls immovable
		for (wall in grpWalls)
		{
			wall.immovable = true;
		}
		add(grpWalls);

		// Spawn balls every 4 seconds
		new FlxTimer().start(4, spawnBall, 0);

		// Add the scoreboard and lives text
		scoreText = new FlxText();
		scoreText.text = "Score: " + score;
		scoreText.size = 32;
		add(scoreText);

		livesText = new FlxText();
		livesText.text = "Lives: " + lives;
		livesText.size = 32;
		livesText.x = 1100;
		add(livesText);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		// Move the goalie when holding right or left
		if (FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.LEFT)
		{
			goalie.move("right");
		}
		else if (FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT)
		{
			goalie.move("left");
		}
		else
		{
			goalie.move("stopped");
		}

		// Check for collision between the walls and goalie
		FlxG.collide(grpWalls, goalie);

		// Check if the goalie has saved the ball
		FlxG.overlap(ball, grpGoalStates, handleGoalStates);

		// Game is over when lives reach 0
		if (lives == 0)
		{
			var gameOverState = new GameOverState();
			gameOverState.score = score;
			FlxG.switchState(gameOverState);
		}

		super.update(elapsed);
	}

	/**
		This function creates a new ball, then initiallizes the ball.
	**/
	function spawnBall(timer:FlxTimer)
	{
		ball = new Ball();
		add(ball);
		ball.init();
	}

	/**
		This function is called when the ball and goalie overlap, and
		checks if the ball is done it's tweening animation. The ball is 
		destroyed if they are still overlapping once the animation is done. 
	**/
	function handleGoalStates(ball:Ball, Obj:FlxSprite)
	{
		// Only check goal state once tween animation is done
		if (ball.doneAnim == true)
		{
			if (Std.isOfType(Obj, Goalie) && !Std.isOfType(Obj, Net))
			{
				{ // Change goalie frame depending on height of ball
					if (ball.y <= 320)
					{
						goalie.animation.frameIndex = 2;
						goalie.updateHitbox();
					}
					else if (ball.y >= 430)
					{
						goalie.animation.frameIndex = 0;
						goalie.updateHitbox();
					}

					// Update the score
					updateScore();
					lives++;
					// Kill the ball that was saved
					ball.kill();
					new FlxTimer().start(0.5, goalie.resetAnimation);
					// trace("hit goalie");
				}
			}
			if (Std.isOfType(Obj, Net) && !Std.isOfType(Obj, Goalie))
			{
				updateLives();
				ball.kill();
			}
		}
	}

	/**
		Updates the score.
	**/
	function updateScore()
	{
		score++;
		scoreText.text = "Score: " + score;
	}

	/**
		Updates the life count.
	**/
	function updateLives()
	{
		lives--;
		livesText.text = "Lives: " + lives;
	}

	/**
		This function takes in the parameters:
		x positon
		y position
		width (default 560)
		height (defualt 8)
		and returns a "wall" FlxSprite.
	**/
	function wall(x, y, width, height):FlxSprite
	{
		return new FlxSprite(x, y).makeGraphic(width, height, FlxColor.TRANSPARENT);
	}
}
