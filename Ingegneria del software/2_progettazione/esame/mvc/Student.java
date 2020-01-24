import java.util.ArrayList;

public class Student extends Observable {
	private ArrayList<Observer> observers;
	private String name;
	private boolean changed;

	public Student(String name) {
		this.name = name;

		observers = new ArrayList<Observer>();
	}

	public void addObserver(Observer o) {
		this.observers.add(o);
	}

	public Observer deleteObserver(Observer o) {
		this.observers.remove(o);
		return o;
	}

	public void setChanged() {
		this.changed = true;
		notifyObservers();
	}

	public void notifyObservers() {
		for (Observer o : observers.toArray(new Observer[observers.size()])) {
			o.update(this, this.name);
		}

		this.changed = false;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
		setChanged();
	}
}
