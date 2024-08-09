import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';


class DiscoverProvider extends ChangeNotifier {
  // TODO: Repository  => Me permite lanzar peticiones http
  final VideoPostRepository videosRepository;

  DiscoverProvider({required this.videosRepository});
  // una capa intermedia entre la lógica de negocio (casos de uso)
  // y las fuentes de datos (bases de datos, APIs, sistemas de archivos,
  // etc.). Su propósito principal es abstraer la lógica de acceso a datos
  // y proporcionar una interfaz coherente para obtener y manipular datos.

  // TODO: DataSource =>
  // se refiere a las implementaciones concretas que manejan los detalles
  // específicos de cómo se obtienen y persisten los datos.
  // Esto puede incluir bases de datos locales, servicios web,
  // cachés en memoria, etc.

  bool initialLoading = true;
  // cuando carga la aplicacion no vamos a tener ningun video cargado.

  // Lista que regresa VideoPost  llamada videos , se inicializa vacia
  List<VideoPost> videos = [];

  // funcion futura que regresa nada (void)
  Future<void> loadNextPage() async {
    //todo cargar videos
    await Future.delayed(const Duration(seconds: 2));

    // recorre los  videoPost del archivo local_video_post
    // lo pasa a LocalVideoModel y de LocalVideoModel a VideoPost
    // como es un iterable que es lo que da el .map lo convertimos en .toList a una lista
    /* final List<VideoPost> newVideos = videoPosts
        .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList();
     */

    final newVideos = await videosRepository.getTrendingVideosByPage(1);
    // esa lista lo agregamos a videos
    videos.addAll(newVideos);
    initialLoading = false;
    notifyListeners(); // le avisamos al provider que hicimos un cambio , repinta la aplicacion
  }
}
