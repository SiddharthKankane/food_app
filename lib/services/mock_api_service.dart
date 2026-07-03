class MockApiService {
  // Simulates a network call to a payment gateway or order database
  static Future<bool> processCheckout(double amount) async {
    // Artificial 2-second delay to mimic network latency
    await Future.delayed(const Duration(seconds: 2));

    // In a real app, this would return true/false based on Stripe/Firebase response
    return true;
  }
}