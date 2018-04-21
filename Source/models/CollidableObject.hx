package models;

import box2D.dynamics.B2FixtureDef;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2World;
import openfl.display.DisplayObject;
import interfaces.CollidableInterface;
import box2D.dynamics.B2Body;

class CollidableObject implements CollidableInterface {
    private var world(null, null):B2World;

    private var asset(null, null):DisplayObject;
    private var body(null, null):B2Body;

    public function new(world:B2World, asset:DisplayObject) {
        this.asset = asset;
        this.world = world;
    }

    public function update():Void {
        this.asset.x = this.body.getPosition().x;
        this.asset.y = this.body.getPosition().y;
    }

    public function createBox(x:Float, y:Float, width:Float, height:Float, is_dynamic:Bool = false):B2Body {
        var body_definition = new B2BodyDef ();
        body_definition.position.set(x, y);

        if (is_dynamic) {
            body_definition.type = B2BodyType.DYNAMIC_BODY;
        }

        var polygon = new B2PolygonShape();
        polygon.setAsBox(width * 0.5, height * 0.5);

        var fixture = new B2FixtureDef();
        fixture.shape = polygon;

        var body = this.world.createBody(body_definition);
        body.createFixture(fixture);

        return body;
    }
}
