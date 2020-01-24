public abstract class Observable {
	public abstract void addObserver(Observer o);
	public abstract Observer deleteObserver(Observer o);
	public abstract void setChanged();
	public abstract void notifyObservers();
}
