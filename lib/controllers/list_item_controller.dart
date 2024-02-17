import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_assignment/models/list_item_model.dart';
import 'package:http/http.dart' as http;

class ListItemController extends GetxController {
  final RxInt pageNum = 1.obs;
  final RxList<Data> displayList = RxList<Data>();
  final RxBool isLoading = false.obs;

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _fetchData(pageNum.value);
    scrollController.addListener(_loadMore);
    update();
  }

  Future<void> _fetchData(int pageKey) async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(
          'https://api-stg.together.buzz/mocks/discovery?page=$pageKey&limit=10'));
      var data = json.decode(response.body.toString());

      if (response.statusCode == 200) {
        ListItem listItem = ListItem.fromJson(data);
        displayList.addAll(listItem.data!);
        isLoading.value = false;
        update();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  void _loadMore() {
        isLoading.value = true;
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value) {
      pageNum.value++;
      _fetchData(pageNum.value);
        isLoading.value = false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
