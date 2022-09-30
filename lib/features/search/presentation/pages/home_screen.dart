import 'package:coco_mobile_explorer/core/constants/api_endpoints.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        Future.delayed(Duration.zero, () {
          debugPrint("Reached the end of the list");
          // BlocProvider.of<PokemonBloc>(context).add(LoadMorePokemon(context));
        });
        // if (continuationLoader.isFalse) {
        //   continuationLoader.value = true;
        //   await loadPokemonResults();
        //   continuationLoader.value = false;
        // }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coco Mobile Explorer'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 200, height: 50, child: TextField()),
              ElevatedButton(onPressed: () {}, child: const Text('Search'))
            ],
          ),
          // ),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const ShowImages();
                }),
          )
        ],
      ),
    );
  }
}

class ShowImages extends StatelessWidget {
  const ShowImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage(AppEndpoints.testimage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
