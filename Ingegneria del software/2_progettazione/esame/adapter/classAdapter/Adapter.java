public class Adapter extends FahrenheitToKelvin {
	@Override
	public int ftok(int f) {
		int celsius = ftoc(f);
		CelsiusToKelvin c = new CelsiusToKelvin();
		return c.ctok(celsius);
	}

	private int ftoc(int f) {
		return ((f-32) * 5) / 9;
	}
}
