package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;

class GameOverState extends FlxState
{
	var background:FlxSprite;
	var playAgainButton:StartButton;

	public var score:Int;

	override public function create()
	{
		// Load the background
		background = new FlxSprite();
		background.loadGraphic("assets/images/gameover_background.png");
		background.antialiasing = true;
		background.setGraphicSize(FlxG.width, FlxG.height);
		background.updateHitbox();
		add(background);

		// Display final score
		var scoreText = new FlxText();
		scoreText.text = "Final Score: " + score;
		scoreText.size = 32;
		scoreText.x = (FlxG.width / 2) - (scoreText.width / 2);
		scoreText.y = (FlxG.height / 2) - 50;
		add(scoreText);

		FlxG.plugins.add(new FlxMouseEventManager());

		// Reuse start button to begin another game
		playAgainButton = new StartButton();
		playAgainButton.init("PLAY AGAIN");
		add(playAgainButton);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
