import 'package:coco_mobile_explorer/features/search/presentation/bloc/search_bloc.dart';
import 'package:coco_mobile_explorer/features/search/presentation/widgets/image_viewer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/error_dialog_widget.dart';

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
          BlocProvider.of<SearchBloc>(context).add(FetchMoreSearchResults(
              searchTextEditingController.text.toLowerCase()));
        });
      }
    });
    super.initState();
  }

  // handles the search button click
  void _handleSearch() {
    String query = searchTextEditingController.text;
    if (query.isNotEmpty) {
      BlocProvider.of<SearchBloc>(context)
          .add(StartSearchAllover()); //Starts all over if keyword is changed
      BlocProvider.of<SearchBloc>(context).add(FetchSearchResults(
          query.toLowerCase())); //fetches When search button is clicked
    }
  }

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
          BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchError) {
                if (state.message.contains('Invalid Category')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text('Invalid Category'),
                    ),
                  );

                  return;
                }
                return showErrorAlert(
                    context: context,
                    description: state.message); //Display error alert dialog
              }
            },
            builder: (context, state) {
              if (state is SearchLoading) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              }

              if (state is SearchResult) {
                return Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.searchResultsModel.images.length +
                          (state.showpaginationLoader ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.searchResultsModel.images.length) {
                          return const SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return ViewImage(
                          imageUrl:
                              state.searchResultsModel.images[index].cocoUrl,
                        );
                      }),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
