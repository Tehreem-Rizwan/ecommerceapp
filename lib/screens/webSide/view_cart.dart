import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewCartScreen extends StatefulWidget {
  static const String id = 'view_cart_screen';

  @override
  State<ViewCartScreen> createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _isRefreshing = false;

  // Add this function to handle refresh
  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });

    try {
      // Wait for a brief moment to show refresh indicator
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh data')),
      );
    } finally {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Cart Items"),
        actions: [
          IconButton(
            icon: _isRefreshing
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(Icons.refresh),
            onPressed: _isRefreshing ? null : _refreshData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('cart')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Stack(
                children: [
                  Center(child: Text("No Cart Items Available")),
                  ListView(),
                ],
              );
            }

            final cartItems = snapshot.data!.docs;

            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                final cartData = cartItem.data() as Map<String, dynamic>;

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            cartData['imageUrl'] ?? '',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData['name'] ?? 'No Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Price: €${cartData['price']}",
                                style: TextStyle(color: Colors.green),
                              ),
                              Text(
                                "Quantity: ${cartData['quantity']}",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                "User: ${cartData['userEmail']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            try {
                              await cartItem.reference.delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Item deleted successfully')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Failed to delete item')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
