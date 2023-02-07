package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Net extends FlxSprite
{
	public function new()
	{
		super();
	}

	public function init():Net
	{
		x = 420;
		y = 260;
		makeGraphic(550, 300, FlxColor.TRANSPARENT);
		return this;
	}
}
