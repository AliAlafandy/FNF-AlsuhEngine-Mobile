package;

import flixel.FlxG;

class TankmenBG extends Sprite
{
	private var tankSpeed:Float;

	private var endingOffset:Float;
	private var goingRight:Bool;

	public var strumTime:Float;

	public function new(x:Float, y:Float, facingRight:Bool):Void
	{
		tankSpeed = 0.7;
		goingRight = false;
		strumTime = 0;
		goingRight = facingRight;

		super(x, y);

		frames = Paths.getSparrowAtlas('tankmanKilled1');

		animation.addByPrefix('run', 'tankman running', 24, true);
		animation.addByPrefix('shot', 'John Shot ' + FlxG.random.int(1, 2), 24, false);
		playAnim('run');

		animation.curAnim.curFrame = FlxG.random.int(0, animation.curAnim.frames.length - 1);

		scale.set(0.8, 0.8);
		updateHitbox();
	}

	public function resetShit(x:Float, y:Float, goingRight:Bool):Void
	{
		this.x = x;
		this.y = y;
		this.goingRight = goingRight;

		endingOffset = FlxG.random.float(50, 200);
		tankSpeed = FlxG.random.float(0.6, 1);
		flipX = goingRight;
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (animation.curAnim.name == 'run')
		{
			var speed:Float = (Conductor.songPosition - strumTime) * tankSpeed;

			if (goingRight) {
				x = (0.02 * FlxG.width - endingOffset) + speed;
			}
			else {
				x = (0.74 * FlxG.width + endingOffset) - speed;
			}
		}
		else if (animation.curAnim.finished) {
			kill();
		}

		if (Conductor.songPosition > strumTime)
		{
			playAnim('shot');

			if (goingRight)
			{
				offset.x = 300;
				offset.y = 200;
			}
		}
	}
}