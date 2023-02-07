package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEvent;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class StartButton extends FlxText
{
	/**
		Extends FlxText to add MouseEvent.
	**/
	public function new():Void
	{
		super();
		FlxMouseEvent.add(this, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
	}

	/**
		Takes a paramter to allow reusability.
		Default = "START"
	**/
	public function init(text = "START"):StartButton
	{
		// Create the text
		this.text = text;
		size = 48;
		color = FlxColor.WHITE;
		x = (FlxG.width / 2) - (this.width / 2);
		y = FlxG.height / 2;

		return this;
	}

	/**
		Bolden the text on mouse down.
	**/
	function onMouseDown(_)
	{
		bold = true;
	}

	/**
		Change state to PlayState on mouse release.
	**/
	function onMouseUp(_)
	{
		FlxG.switchState(new PlayState());
	}

	/**
		Add a shadow on mouse hover.
	**/
	function onMouseOver(_)
	{
		setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 5);
	}

	/**
		Remove shadow when done hovering with mouse.
	**/
	function onMouseOut(_)
	{
		setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 0);
	}
}
