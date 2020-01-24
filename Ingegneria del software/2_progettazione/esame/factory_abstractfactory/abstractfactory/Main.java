public class Main {
	public static void main(String[] args) {
		AbstractFactory factory = new RectangleFactory();
		Shape shape1 = factory.getShape();
		RoundedShape shape2 = factory.getRoundedShape();
		shape1.draw();
		shape2.draw(2);

		factory = new SquareFactory();
		shape1 = factory.getShape();
		shape2 = factory.getRoundedShape();
		shape1.draw();
		shape2.draw(2);
	}
}
