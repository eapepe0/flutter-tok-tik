import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayer extends StatefulWidget {
  // propiedades

  final String videoUrl;
  final String caption;

  const FullscreenPlayer({
    super.key, 
    required this.videoUrl, 
    required this.caption
    });

  @override
  State<FullscreenPlayer> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {
  late VideoPlayerController controller;

  @override
  // inicio de ciclo de vida del StatefulWidget
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset(widget.videoUrl) // Cargamos el video
      ..setVolume(0) // seteamos el volumen en 0
      ..setLooping(true) // vuelve a comenzar cuando termina
      ..play(); // reproducimos
  }

  // cuando termina el ciclo tenemos que "tirar" el widget
  @override

  // se llama cuando el widget se elimina de la árbol de widgets
  void dispose() {

    // En dispose, debes liberar cualquier recurso que 
    // hayas creado en initState o en cualquier otro lugar del widget.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // creamos con el builder
    return FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) { // si la conexion nos da que no esta lista
            // mostramos un spinner
            return const Center(
                child: CircularProgressIndicator(
                strokeWidth: 2,
              )
            );
          }
          return GestureDetector( // gesto sobre la pantalla , un tap pausamos otro tap play
            onTap: () {
              if (controller.value.isPlaying) {
                controller.pause();
                return;
              }
              controller.play();
            },
            child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: Stack(children: [
                  VideoPlayer(controller), // reproductor de video
                  // Gradiente
                  VideoBackground( // gradiente que se pone del 80% de la pantalla al 100%
                    stops: const [0.8 , 1.0]
                  ),
                  // Texto
                  Positioned( // texto arriba del video
                      bottom: 50,
                      left: 20,
                      child: _VideoCaption(caption: widget.caption))
                ])),
          );
        });
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;

  const _VideoCaption({required this.caption});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; // tomamos el tamaño de la pantalla
    final titleStyle = Theme.of(context).textTheme.titleLarge; // sacamos del contexto del theme si tiene alguna fuente grande

    // devolvemos una caja con el 60% del ancho , y con el texto
    return SizedBox(
      width: size.width * 0.6,
      child: Text(caption, maxLines: 2, style: titleStyle),
    );
  }
}
