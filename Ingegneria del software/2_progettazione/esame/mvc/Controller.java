public class Controller {
	private Student model;

	public Controller(Student model) {
		this.model = model;
	}

	public void setStudentName(String name) {
		this.model.setName(name);
	}
}
