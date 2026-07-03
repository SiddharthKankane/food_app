class CheckoutOptions {
  String deliveryAddress;
  String deliveryInstructions;
  String paymentMethod;

  CheckoutOptions({
    this.deliveryAddress = "123 Main St, Delhi",
    this.deliveryInstructions = "Please leave at the door.",
    this.paymentMethod = "Cash on Delivery",
  });
}
