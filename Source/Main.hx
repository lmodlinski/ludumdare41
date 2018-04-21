package;

import models.Ground;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2World;
import models.Player;
import models.Ball;
import models.Platform;
import openfl.Lib;
import openfl.Vector;
import openfl.display.FPS;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite {
    private static inline var PHYSICS_SCALE:Float = 30.0;

    private var world_asset(null, null):WorldAsset;
    private var world(null, null):B2World;

    private var ball(null, null):Ball;

    private var platforms(null, null):Vector<Platform>;

    private var ground(null, null):Ground;

    private var player(null, null):Player;

    public function new() {
        super();

        Lib.current.stage.align = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        this.addChild(this.world_asset = new WorldAsset());
        this.world = new B2World(new B2Vec2(0.0, 9.8), true);

        this.initializeDebug();
        this.initializeListeners();

        this.player = new Player(this.world, this.world_asset.player);

        this.ball = new Ball(this.world, this.world_asset.ball, 0.3);
        this.ground = new Ground(this.world, this.world_asset.ground);

        this.platforms = new Vector<Platform>();
        this.platforms.push(new Platform(this.world, this.world_asset.platform_1));
        this.platforms.push(new Platform(this.world, this.world_asset.platform_2));

        this.addChild(new FPS());

        this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(event:Event):Void {
        this.world.step(1 / PHYSICS_SCALE, 10, 10);
        this.world.clearForces();
        this.world.drawDebugData();

        this.ball.update();
        this.player.update();
        this.ground.update();

        for (platform in this.platforms) {
            platform.update();
        }
    }

    private function initializeDebug():Void {
        var debug_draw = new B2DebugDraw ();
        debug_draw.setSprite(this);
        debug_draw.setDrawScale(1.0);
        debug_draw.setFlags(B2DebugDraw.e_shapeBit);

        this.world.setDebugDraw(debug_draw);
    }

    private function initializeListeners():Void {
        this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        this.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
    }

    private function onKeyDown(e:KeyboardEvent):Void {
        switch(e.keyCode){
            case Keyboard.A:
                this.player.moving = PlayerMove.LEFT;
            case Keyboard.D:
                this.player.moving = PlayerMove.RIGHT;
            case Keyboard.SPACE:
                this.player.jump();
        }
    }

    private function onKeyUp(e:KeyboardEvent):Void {
        switch(e.keyCode){
            case Keyboard.A | Keyboard.D:
                this.player.moving = PlayerMove.IDLE;
            case Keyboard.SPACE:
        }
    }
}