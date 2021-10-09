public class Main {
	public static void main(String[] args) {
		FahrenheitToKelvin fk = new FahrenheitToKelvin();
		System.out.println(fk.ftok(3244));

		FahrenheitToKelvin fk1 = new Adapter();
		System.out.println(fk1.ftok(3244));
	}
}
