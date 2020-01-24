public class Main {
	public static void main(String[] args) {
		Duck duffyDuck = new Duck();
		Fly f = new FlyWithRocket();
		Quack q = new Squok();

		duffyDuck.setFlyStrategy(f);
		duffyDuck.setQuackStrategy(q);

		duffyDuck.performQuack();
		duffyDuck.performFly();
	}
}
