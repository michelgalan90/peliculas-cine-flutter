import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        // containerHeight: double.infinity,
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.65,
        itemHeight: _screenSize.height * 0.48,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-swiper';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'detalle',
                      arguments: peliculas[
                          index]); //aqui mando mi instancia de peliculas de swiper, que es fija porque nacen en un future y no se vuelven a fabricar mas, esta instancia que le mando aca, es diferente a la instancia de pelicula que le mando desde el movie horizontal, son dos instancias diferentes y en la pagina detalle dependiente de si doy clic en swiper o en horizontal, mandara su respectiva instancia de pelicula...eso significa que si voy desde card_swiper y mando la instancia de pelicula de swiper tendra el mismo uniqueId que le proporciono al Hero, y luego en pelicula_detalle puedo usar ese mismo id para hacer el hero animation
                },
                child: FadeInImage(
                  image: NetworkImage(
                    peliculas[index].getPostImg(),
                  ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover, //para que los bordes se vean bacanos
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length,

        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
