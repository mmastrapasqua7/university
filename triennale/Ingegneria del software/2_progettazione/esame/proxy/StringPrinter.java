public class StringPrinter implements Service {
	public String printNumbers(String[] numbers) {
		String result = "";
		for (String s: numbers) {
			result += s + " ";
		}

		return result;
	}
}
