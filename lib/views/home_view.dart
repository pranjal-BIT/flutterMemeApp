import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memer/services/apis.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Text("Reached end");
      }
    });
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meme app"),
      ),
      body: FutureBuilder(
        future: API.getMemes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.custom(
              controller: _scrollController,
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  final meme = snapshot.data!.data!.memes![index];
                  return InkWell(
                    onTap: () => launchUrl(Uri.parse(meme.url!)),
                    child: Stack(
                      children: [
                        Card(
                          child: Center(
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: meme.url!,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            child: Text(meme.name!),
                            color: Colors.black.withOpacity(0.5),
                            padding: EdgeInsets.all(8),
                          ),
                          bottom: 0,
                          right: 0,
                          left: 0,
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
