public class Main {
	public static void main(String[] args) {
		int fahrenheit = 43580;
		System.out.println(FahrenheitToKelvin.ftok(fahrenheit));
		
		int celsius = ((fahrenheit - 32) * 5) / 9;
		Converter c = new Adapter();
		System.out.println(c.ctok(celsius));
	}
}
