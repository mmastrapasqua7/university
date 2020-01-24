public class Duck {
	private Fly flyStrategy;
	private Quack quackStrategy;

	public void setFlyStrategy(Fly f) {
		this.flyStrategy = f;
	}

	public void setQuackStrategy(Quack q) {
		this.quackStrategy = q;
	}

	public void performQuack() {
		quackStrategy.quack();
	}

	public void performFly() {
		flyStrategy.fly();
	}
}
