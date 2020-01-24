public class RectangleFactory extends AbstractFactory {
	@Override
	public Shape getShape() {
		return new Rectangle();
	}

	@Override
	public RoundedShape getRoundedShape() {
		return new RoundedRectangle();
	}
}
