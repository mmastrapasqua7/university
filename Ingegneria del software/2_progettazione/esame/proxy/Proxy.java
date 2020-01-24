public class Proxy implements Service {
	public Service s = null;

	public Proxy(Service s) {
		this.s = s;
	}

	public String printNumbers(String[] numbers) {
		if (this.s != null) {
			String result = (this.s).printNumbers(numbers).trim();
			String[] array = result.split(" ");

			result = "";
			for (int i = 0; i < array.length; i++) {
				result += "" + i + ": " + array[i] + "\n";
			}

			return result;
		}
		return "";
	}
}
