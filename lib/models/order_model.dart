class PastOrder {
  final String id;
  final String date;
  final double totalAmount;
  final String status;
  final List<OrderItem> items;

  PastOrder({
    required this.id,
    required this.date,
    required this.totalAmount,
    required this.status,
    required this.items,
  });
}

// A simplified item just for the receipt
class OrderItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  OrderItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

// Our mock database of past orders
List<PastOrder> dummyOrders = [
  PastOrder(
    id: "ORD-9824",
    date: "Oct 12, 2023 • 6:30 PM",
    totalAmount: 26.98,
    status: "Delivered",
    items: [
      OrderItem(id: '1', title: 'Classic Cheeseburger', price: 8.99, quantity: 2),
      OrderItem(id: '4', title: 'Double Bacon Burger', price: 12.99, quantity: 1),
    ],
  ),
  PastOrder(
    id: "ORD-7731",
    date: "Oct 05, 2023 • 1:15 PM",
    totalAmount: 14.50,
    status: "Delivered",
    items: [
      OrderItem(id: '2', title: 'Pepperoni Pizza', price: 14.50, quantity: 1),
    ],
  ),
];
