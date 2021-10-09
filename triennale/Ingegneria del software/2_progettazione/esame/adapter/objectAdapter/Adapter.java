public class Adapter implements Converter {
	// private adaptee FahrenheitToKelvin;
	
	public int ctok(int c) {
		int f = (c*9)/5 + 32;
		return FahrenheitToKelvin.ftok(f);
	}
}
