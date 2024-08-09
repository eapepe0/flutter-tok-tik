// Entities , son las clases que representan nuestras entidades de la capa de negocio. 
// Contienen sus métodos de interacción además de su serialización y deserialización.

class VideoPost {
  
  // propiedades
    final String caption;
    final String videoUrl;
    final int likes;
    final int views;
    
  // constructor

  VideoPost({
    required this.caption,
    required this.videoUrl, 
    this.likes = 0, 
    this.views = 0
  });

  // metodos
}

