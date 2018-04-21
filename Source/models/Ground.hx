package models;

import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import openfl.display.DisplayObject;

class Ground extends CollidableObject {
    public function new(world:B2World, asset:DisplayObject) {
        super(world, asset);

        var body_definition = new B2BodyDef();
        body_definition.position.set(this.asset.x, this.asset.y);

        var polygon = new B2PolygonShape();
        polygon.setAsOrientedBox(this.asset.width * 0.5, this.asset.height * 0.5, new B2Vec2(0.0, 0.0), this.asset.rotation);

        var fixture = new B2FixtureDef();
        fixture.shape = polygon;

        this.body = this.world.createBody(body_definition);
        this.body.createFixture(fixture);
    }
}
