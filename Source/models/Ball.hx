package models;

import box2D.dynamics.B2FixtureDef;
import box2D.collision.shapes.B2CircleShape;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2World;
import openfl.display.DisplayObject;

class Ball extends CollidableObject {
    public function new(world:B2World, asset:DisplayObject, bounciness:Float) {
        super(world, asset);

        var body_definition = new B2BodyDef ();
        body_definition.position.set(this.asset.x, this.asset.y);
        body_definition.type = B2BodyType.DYNAMIC_BODY;

        var circle = new B2CircleShape (this.asset.width * 0.5);

        var fixture = new B2FixtureDef ();
        fixture.shape = circle;
        fixture.restitution = bounciness;

        this.body = this.world.createBody(body_definition);
        this.body.createFixture(fixture);
    }
}
