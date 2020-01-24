public class View implements Observer {
	private Observable model;
	private Controller controller;
	private String studentName;

	public View(Observable model, Controller controller) {
		this.model = model;
		this.controller = controller;
	}

	public void display() {
		System.out.println("Welcome " + this.studentName);
	}

	public void update(Observable o, Object arg) {
		this.studentName = (String)arg;
		display();
	}

	public void changeStudentName(String name) {
		controller.setStudentName(name);
	}
}
