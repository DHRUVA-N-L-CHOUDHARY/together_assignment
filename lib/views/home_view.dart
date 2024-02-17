import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_assignment/controllers/list_item_controller.dart';
import 'package:together_assignment/models/list_item_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListItemController>(
        init: ListItemController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Together Assignment',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.red[400],
            ),
            body: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.displayList.length +
                  (controller.isLoading.value == true
                      ? 1
                      : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index == controller.displayList.length) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: SizedBox(
                        // width: 100,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
                Data listItem = controller.displayList[index];
                return ListTile(
                  title: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            listItem.imageUrl.toString(),
                            width: Get.width,
                            height: 150,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            listItem.title.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            listItem.description.toString(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
