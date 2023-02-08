package;

import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.tweens.FlxTween;

class Ball extends FlxSprite
{
	public var doneAnim:Bool;

	var rand = new FlxRandom();

	public function new()
	{
		super();
		doneAnim = false;
	}

	public function init():Ball
	{
		x = ballSpawnPoint();
		y = 770;
		loadGraphic("assets/images/soccerball.png");
		var dest = ballDestination();
		FlxTween.tween(this, {
			x: dest[0],
			y: dest[1],
			"scale.x": 0.5,
			"scale.y": 0.5,
		}, tweenSpeed(), {onComplete: doneTweening, onUpdate: updHitbox});

		return this;
	}

	/**
		This function changes the duration/speed of the tween animation.
	**/
	public function tweenSpeed():Float
	{
		return rand.float(0.5, 1.5);
	}

	/**
		This function randomly generates an x and y value within the range of the net.
	**/
	public function ballDestination():Array<Int>
	{
		var x = rand.int(410, 910);
		var y = rand.int(260, 490); //   490
		return [x, y];
	}

	/**
		This function randomly generates an x position.
	**/
	public function ballSpawnPoint():Int
	{
		var x = rand.int(350, 930);
		return x;
	}

	/**
		This function updates the tweening bool and updates the hitbox.
	**/
	public function doneTweening(tween:FlxTween):Void
	{
		doneAnim = true;
		updateHitbox();
		// trace("done tween");
	}

	/**
		This function updates the hitbox, called during the tweening animation.
	**/
	public function updHitbox(tween:FlxTween):Void
	{
		updateHitbox();
		// trace("updating");
	}
}
