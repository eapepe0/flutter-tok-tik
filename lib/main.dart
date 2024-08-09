import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';
import 'package:toktik/infrastructure/datasources/local_video_datasource_impl.dart';
import 'package:toktik/infrastructure/repository/video_posts_repository_impl.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPostRepository = VideoPostsRepositoryImpl(
            videosDatasource: LocalVideoDatasource()
          );
    return MultiProvider(
      providers: [
        // el operador (..) se llama cascada , seria como un apuntar de nuevo al objeto raiz
        ChangeNotifierProvider(
            lazy:
                false, // por defecto se crea el constructor del provider cuando se va a utilizar
            //, poniendolo en false se construye cuando se lanza la aplicacion
            create: (_) => DiscoverProvider(videosRepository: videoPostRepository)..loadNextPage())
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Toktik',
        theme: AppTheme().getTheme(),
        home: const Scaffold(
          body: Center(
            child: DiscoverScreen(),
          ),
        ),
      ),
    );
  }
}
