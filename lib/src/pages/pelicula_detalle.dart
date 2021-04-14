import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    PeliculasProvider futureActor = PeliculasProvider();

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          /* SliverGrid(
            delegate: SliverChildListDelegate([
              Icon(Icons.account_balance_outlined),
              Text('Hola'),
              Text('PERRA😎')
            ]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 3.0,
                childAspectRatio: 3.0),
          ), */
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _posterTitulo(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula, futureActor),
              ],
            ),
            // lista.map((l) => ListTile(title: Text(l))).toList()))
          )
        ],
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula, PeliculasProvider futureActor) {
    return FutureBuilder(
      future: futureActor.procesarActor(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, index) {
          return _actorTarjeta(actores[index]);
        },
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              height: 150.0,
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(
                actor.getFoto(),
              ),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(
                  pelicula.getPostImg(),
                ),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  pelicula.originalTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      stretch: false,
      actions: [
        /*  IconButton(
          icon: Icon(Icons.agriculture),
          onPressed: () {},
        ), */
        PopupMenuButton(
            // child: Text('hola'),

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            itemBuilder: (conteo) {
              return [
                PopupMenuItem(
                  enabled: true,
                  height: 10.0,
                  child: Text('😂Demo'),
                ),
                PopupMenuItem(
                  enabled: true,
                  height: 10.0,
                  child: Text('🙂Demo2'),
                ),
                PopupMenuItem(
                  enabled: true,
                  height: 10.0,
                  child: Text('🙄Demo3'),
                ),
                PopupMenuItem(
                  enabled: true,
                  height: 10.0,
                  child: Text('😎Demo4'),
                ),
              ];
            }),
      ],
      /* title: Text(
        pelicula.title,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                  blurRadius: 10.0,
                  color: Colors.blue,
                  offset: Offset(2.0, 2.0))
            ]),
      ), */
      centerTitle: true,
      elevation: 12.0,
      backgroundColor: Colors.pink,
      expandedHeight: 200.0,
      floating: true,
      shadowColor: Colors.yellow,
      pinned: true,
      forceElevated: false,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.fadeTitle],
        collapseMode: CollapseMode.parallax,
        centerTitle: true,
        title: Text(
          pelicula.title,
          textAlign: TextAlign.center,
        ),
        background: FadeInImage(
          fadeInDuration: Duration(milliseconds: 500),
          fit: BoxFit.cover,
          image: NetworkImage(
            pelicula.getBackgroundImg(),
          ),
          placeholder: AssetImage('assets/img/loading.gif'),
        ),
      ),
    );
  }
}
