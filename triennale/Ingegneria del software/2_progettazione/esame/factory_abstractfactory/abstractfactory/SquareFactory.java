public class SquareFactory extends AbstractFactory {
	@Override
	public Shape getShape() {
		return new Square();
	}

	@Override
	public RoundedShape getRoundedShape() {
		return new RoundedSquare();
	}
}
