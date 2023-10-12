import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memer/services/apis.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meme app"),
      ),
      body: FutureBuilder(
        future: API.getMemes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.data!.memes!.length,
              itemBuilder: (context, index) {
                final meme = snapshot.data!.data!.memes![index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: meme.url!,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  title: Text(meme.name!),
                  subtitle: Text(meme.url!),
                );
              },
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
