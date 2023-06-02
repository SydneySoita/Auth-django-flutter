import 'dart:collection';
import 'dart:ffi';

class Expense {
  final int id;
  final String title;
  final String description;
  final int amount;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.category,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      title: json['title'],
      id: json['id'],
      description: json['description'],
      amount: json['amount'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'amount': amount,
      'category': category,
    };
  }
}
