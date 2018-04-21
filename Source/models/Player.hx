package models;

import box2D.common.math.B2Vec2;
import box2D.common.math.B2Transform;
import box2D.collision.shapes.B2MassData;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2FixtureDef;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2World;
import openfl.display.DisplayObject;

class Player extends CollidableObject {
    private static inline var JUMP_FORCE:Float = -100000.0;

    public var moving(default, default):PlayerMove;
    public var jumping(default, default):Bool;

    public function new(world:B2World, asset:DisplayObject) {
        super(world, asset);

        var body_definition = new B2BodyDef();
        body_definition.position.set(this.asset.x, this.asset.y);
        body_definition.type = B2BodyType.DYNAMIC_BODY;
        body_definition.linearDamping = 0.7;
        body_definition.angularDamping = 0.7;

        var polygon = new B2PolygonShape();
        polygon.setAsOrientedBox(this.asset.width * 0.5, this.asset.height * 0.5, new B2Vec2(0.0, 0.0), this.asset.rotation);

        var fixture = new B2FixtureDef();
        fixture.shape = polygon;
        fixture.friction = 0.0;

        var mass = new B2MassData();
        mass.mass = 100.0;

        this.body = this.world.createBody(body_definition);
        this.body.createFixture(fixture);
        this.body.setMassData(mass);
        this.body.setLinearDamping(1.0);

        this.moving = PlayerMove.IDLE;
    }

    override public function update():Void {
        super.update();

        switch(this.moving){
            case PlayerMove.LEFT:
                this.body.applyImpulse(new B2Vec2(this.body.getMass() * (-50.0 - this.body.getLinearVelocity().x), 0), this.body.getWorldCenter());
            case PlayerMove.RIGHT:
                this.body.applyImpulse(new B2Vec2(this.body.getMass() * (50.0 - this.body.getLinearVelocity().x), 0), this.body.getWorldCenter());
            case PlayerMove.IDLE:
        }
    }

    public function jump():Void {
        this.body.applyImpulse(new B2Vec2(0.0, JUMP_FORCE), this.body.getLocalCenter());
    }

    public function kick():Void {

    }
}

enum PlayerMove {
    IDLE;

    LEFT;
    RIGHT;
}