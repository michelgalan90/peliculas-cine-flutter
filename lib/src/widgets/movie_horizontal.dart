import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  final PeliculasProvider peliculasProvider;

  MovieHorizontal({@required this.peliculas, this.peliculasProvider});

  final PageController _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.32,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    /*  _pageController.addListener(() {
      if (_pageController.page >= peliculas.length - 1) {
        provider.getPopularMovie();
      }
    }); */

    return Container(
      // color: Colors.green,
      height: _screenSize.height * 0.32,

      child: PageView.builder(
        onPageChanged: (value) {
          if (value == peliculas.length - 1) {
            peliculasProvider.getPopularMovie();
          }
        },
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          return tarjeta(context, peliculas[index], _screenSize);
        },
      ),
    );
  }

  Widget tarjeta(BuildContext context, Pelicula pelicula, Size tamano) {
    pelicula.uniqueId = '${pelicula.id}-horizontal';
    final tarjeta = Container(
      // color: Color.fromRGBO(255, 255, 255, 0.5),
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  pelicula.getPostImg(),
                ),
                fit: BoxFit.cover,
                height: tamano.height * 0.21,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle',
            arguments:
                pelicula); //aqui yo mando mi instancia de peliculas horizontal que aumentan cada 20 peliculas cada vez que voy descubriendo mas peliculas porque es un stream, es una instancia diferente de la instancia del swiper por lo tanto este pelicula que mando al momento de fabricar el pelicula_detalle usa esta instnacia que tiene mi uniqueId especifico y que fue puesto en el mismo Hero.tag
      },
      child: tarjeta,
    );
  }

  /* List<Widget> _tarjetas(Size tamano, BuildContext context) {
    return peliculas.map((pelicula) {
      return 
    }).toList();
  } */
}
