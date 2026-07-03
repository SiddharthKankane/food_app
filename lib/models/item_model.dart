class Item {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

// Global Menu with at least 4 items per category
List<Item> dummyMenu = [
  // --- BURGERS ---
  Item(
    id: 'b1',
    title: 'Classic Cheeseburger',
    description: 'Juicy beef patty with melted cheddar, lettuce, and tomato.',
    price: 8.99,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png',
    category: 'Burgers',
  ),
  Item(
    id: 'b2',
    title: 'Double Bacon Burger',
    description: 'Two beef patties, crispy bacon, BBQ sauce, and onions.',
    price: 12.99,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png',
    category: 'Burgers',
  ),
  Item(
    id: 'b3',
    title: 'Spicy Zinger Burger',
    description: 'Crispy chicken fillet with spicy mayo and jalapeños.',
    price: 9.50,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png',
    category: 'Burgers',
  ),
  Item(
    id: 'b4',
    title: 'Veggie Delight Burger',
    description: 'Grilled plant-based patty with avocado and sprouts.',
    price: 10.99,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png',
    category: 'Burgers',
  ),

  // --- PIZZA ---
  Item(
    id: 'p1',
    title: 'Pepperoni Passion',
    description: 'Loaded with double pepperoni and extra mozzarella.',
    price: 14.50,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3132/3132693.png',
    category: 'Pizza',
  ),
  Item(
    id: 'p2',
    title: 'Margherita Classic',
    description: 'Fresh basil, bocconcini, and rich tomato sauce.',
    price: 11.99,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3595/3595455.png',
    category: 'Pizza',
  ),
  Item(
    id: 'p3',
    title: 'BBQ Chicken Pizza',
    description: 'Grilled chicken, red onions, and sweet BBQ drizzle.',
    price: 15.99,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3132/3132693.png',
    category: 'Pizza',
  ),
  Item(
    id: 'p4',
    title: 'Veggie Supreme',
    description: 'Bell peppers, olives, mushrooms, and sweetcorn.',
    price: 13.50,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3132/3132693.png',
    category: 'Pizza',
  ),

  // --- HEALTHY ---
  Item(
    id: 'h1',
    title: 'Vegan Greek Salad',
    description: 'Crispy greens, olives, cucumber, and tofu feta.',
    price: 7.99,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/1149/1149069.png',
    category: 'Healthy',
  ),
  Item(
    id: 'h2',
    title: 'Acai Power Bowl',
    description: 'Organic acai topped with berries, granola, and honey.',
    price: 9.50,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/2917/2917620.png',
    category: 'Healthy',
  ),
  Item(
    id: 'h3',
    title: 'Quinoa Buddha Bowl',
    description: 'Roasted chickpeas, kale, quinoa, and tahini dressing.',
    price: 11.25,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/1149/1149069.png',
    category: 'Healthy',
  ),
  Item(
    id: 'h4',
    title: 'Avocado Toast',
    description: 'Sourdough bread with smashed avocado and chili flakes.',
    price: 8.75,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/2917/2917620.png',
    category: 'Healthy',
  ),

  // --- DRINKS ---
  Item(
    id: 'd1',
    title: 'Mango Smoothie',
    description: 'Real mango chunks blended with creamy Greek yogurt.',
    price: 5.50,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3130/3130310.png',
    category: 'Drinks',
  ),
  Item(
    id: 'd2',
    title: 'Iced Caramel Latte',
    description: 'Double shot espresso with cold milk and caramel syrup.',
    price: 4.99,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3130/3130310.png',
    category: 'Drinks',
  ),
  Item(
    id: 'd3',
    title: 'Fresh Lemonade',
    description: 'Hand-squeezed lemons with mint and sparkling water.',
    price: 3.50,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3130/3130310.png',
    category: 'Drinks',
  ),
  Item(
    id: 'd4',
    title: 'Berry Detox Tea',
    description: 'Warm infusion of mixed forest berries and hibiscus.',
    price: 4.25,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3130/3130310.png',
    category: 'Drinks',
  ),
];
