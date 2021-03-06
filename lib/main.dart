import 'package:academiainnova/Paginas/login.dart';
import 'package:academiainnova/Paginas/register.dart';
import 'package:academiainnova/routes.dart';
import 'package:academiainnova/slider.dart';
import 'package:academiainnova/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget rootPage = InicioApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACADEMIA',
      home: rootPage, //esta clase lo creamos bajo
      routes: buildAppRoutes(),
      theme: buildAppTheme(),
    );
  }
}

class InicioApp extends StatefulWidget {
  @override
  _InicioAppState createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> {
  //declaramos las variables y inicalizamos
  // ignore: unused_field
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
      //este SliderPage viene de slider.dart ahi esta declarado
      title: "Poner titulo aqui",
      descripcion: "Aqui ponemos una descripcion relacionado con el tema",
      image: "assets/1.svg",
    ),
    SliderPage(
      title: 'Poner titulo aqui',
      descripcion: 'Aqui ponemos una descripcion relacionado con el tema',
      image: 'assets/2.svg',
    ),
    SliderPage(
      title: 'Poner titulo aqui',
      descripcion: 'Aqui ponemos una descripcion relacionado con el tema',
      image: 'assets/3.svg',
    ),
  ]; //siempre despues de corchete cerrar con punto y coma ojo pero en <widget> solo cierra con coma

  _onChanged(int index) {
    setState(() {
      _currentPage =
          index; //aqui vemos el estado para pasar de una pantalla a otro
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: _onChanged,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          //Creamos botoncitos de nav dentro de hijo widget
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(_pages.length, (int index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 10,
                    width: (index == _currentPage) ? 30 : 10,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: (index == _currentPage)
                            ? Colors.blue
                            : Colors.blue.withOpacity(0.5)),
                  );
                }),
              ),
              //creamos el circulo con el next cuando se da click
              InkWell(
                onTap: () {
                  _controller.nextPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOutQuint);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 60,
                  alignment: Alignment.center,
                  width: (_currentPage == (_pages.length - 1))
                      ? 200
                      : 60, //con este -1 decimos que se haga el efecto de empezar en el ultimo activity
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: (_currentPage == (_pages.length - 1))
                      ? Container(
                          width: size.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(23),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    //builder: (context) => LoginPage(),
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Empezar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                            ),
                          ),
                        )
                      : Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 50,
                        ),
                ),
              ),

              //con este le subimos el boton - (botom-border)
              SizedBox(height: 50),

              //creamos el boton empezar
            ],
          ),
        ],
      ),
    );
  }
}
