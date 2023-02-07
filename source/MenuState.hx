package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.mouse.FlxMouseEventManager;

class MenuState extends FlxState
{
	var background:FlxSprite;
	var startButton:StartButton;

	override public function create()
	{
		// Load the background
		background = new FlxSprite();
		background.loadGraphic("assets/images/menu_background.png");
		background.antialiasing = true;
		background.setGraphicSize(FlxG.width, FlxG.height);
		background.updateHitbox();
		add(background);

		// Add the MouseEventManager
		FlxG.plugins.add(new FlxMouseEventManager());

		// Create a start button
		startButton = new StartButton();
		startButton.init();
		add(startButton);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
