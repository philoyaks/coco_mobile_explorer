import 'package:coco_mobile_explorer/features/search/presentation/widgets/image_viewer_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        Future.delayed(Duration.zero, () {
          debugPrint("Reached the end of the list");
        });
      }
    });
    super.initState();
  }

  void _handleSearch() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coco Mobile Explorer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 52,
                  child: TextField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () => _handleSearch(),
                    child: const Text('Search'))
              ],
            ),
          ),
          // ),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const ViewImage();
                }),
          )
        ],
      ),
    );
  }
}
