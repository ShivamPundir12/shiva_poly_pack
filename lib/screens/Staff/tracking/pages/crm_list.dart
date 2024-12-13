import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/controller/crm_list.dart';

class CRMListScreen extends GetView<CRMListController> {
  CRMListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRM List'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.customerList.length,
            itemBuilder: (context, index) {
              final customer = controller.customerList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Name and Phone Number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            customer['name'].toString() ?? 'N/A',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            customer['phoneNumber'].toString() ?? 'N/A',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Location and Business Tag
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Location: ${customer['location'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Business: ${customer['businessTag'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Tags using Chips
                      Wrap(
                        spacing: 8,
                        children: List<Widget>.generate(
                          (customer['tags'] as List<dynamic>?)?.length ?? 0,
                          (tagIndex) => Chip(
                            label: Text(
                              customer['tags'].toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Last Comment and Party Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Last Comment: ${customer['lastComment'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Party: ${customer['partyName'] ?? 'N/A'}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Add Tagging Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => controller.addTag(index, 'New Tag'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent),
                          child: const Text(
                            'Add Tagging',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
