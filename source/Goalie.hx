package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxRandom;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class Goalie extends FlxSprite
{
	var movSpd = 400;

	public function new()
	{
		super();
	}

	public function init():Goalie
	{
		x = 605;
		y = 250;
		// Load the spritesheet
		var spritesheet = FlxAtlasFrames.fromTexturePackerJson("assets/images/spritesheet.png", "assets/images/spritesheet.json");
		frames = spritesheet;
		antialiasing = true;
		// Default animation is the standing one
		animation.frameIndex = 1;

		return this;
	}

	/**
		Moves the sprite in right or left direction
		Direction = "right" or "left", anything else stops the movement
	**/
	public function move(direction:String)
	{
		if (direction == "right")
		{
			velocity.x = movSpd;
		}
		else if (direction == "left")
		{
			velocity.x = movSpd * -1;
		}
		else
		{
			velocity.x = movSpd * 0;
		}
	}

	/**
		Resets the goalie animation to default frame
	**/
	public function resetAnimation(timer:FlxTimer)
	{
		animation.frameIndex = 1;
	}
}
