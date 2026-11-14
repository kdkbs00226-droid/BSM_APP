import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
runApp(const BillingSystemApp());
}

class BillingSystemApp extends StatelessWidget {
const BillingSystemApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,

// Login page
home: LoginPage(),

// App routes
routes: {
'/login': (context) => LoginPage(),
},
);
}
}
