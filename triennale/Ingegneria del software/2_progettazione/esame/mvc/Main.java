public class Main {
	public static void main(String[] args) {
		Student student = new Student("Aldo");
		Controller controller = new Controller(student);
		View normalView = new View(student, controller);
		View2 bitchView = new View2(student, controller);

		student.addObserver(normalView);
		student.addObserver(bitchView);

		controller.setStudentName("Cicciogamer");
	}
}
