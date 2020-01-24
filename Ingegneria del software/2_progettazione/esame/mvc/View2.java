public class View2 implements Observer {
	private Observable model;
	private Controller controller;
	private String studentName;

	public View2(Observable model, Controller controller) {
		this.model = model;
		this.controller = controller;
	}

	public void display() {
		System.out.println("Welcome you son of a bitch " + this.studentName);
	}

	public void update(Observable o, Object arg) {
		this.studentName = (String)arg;
		display();
	}
}
