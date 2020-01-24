public class Main {
	public static void main(String[] args) {
		Computer pc = ComputerFactory.getComputer("PC", "16GB", "500GB", "Pentium");
		Computer server = ComputerFactory.getComputer("Server", "256GB", "1TB", "Xeon e5");
		System.out.println("PC config: " + pc);
		System.out.println("Server config: " + server);
	}
}
