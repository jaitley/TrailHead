public class AwesomeCalculator {
    public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort calc = new calculatorServices.CalculatorImplPort();
        return calc.doAdd(x, y);
    }
}
