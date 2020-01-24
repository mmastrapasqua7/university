public class Main {
	public static void main(String[] args) {
		String[] numbers = {"1","2","34","435","435","234324","656","876","8","78989","68"};
		Service s = new StringPrinter();
		System.out.println(s.printNumbers(numbers));

		Service p = new Proxy(s);
		System.out.println(p.printNumbers(numbers));
	}
}
