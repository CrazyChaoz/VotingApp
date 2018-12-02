import 'package:flutter/material.dart';
import 'package:http/http.dart' show Response, Client;

void main() => runApp(MyApp());

String jona = "0;0";

Container getBackgroundWidget(Widget child) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: ExactAssetImage('images/marlboro.jpg'),
        fit: BoxFit.fill,
      ),
    ),
    alignment: Alignment.bottomCenter,
    child: child,
  );
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _sendNotification() {
    setState(() {
      //do networking stuff

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResultScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return getBackgroundWidget(
      GestureDetector(
        onTap: _sendNotification,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(153, 153, 102, 1),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
            ),
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          child: Text(
            "Gemma Rauchn",
            textScaleFactor: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Marlboro",
              fontSize: 35,
              color: Color.fromRGBO(22, 115, 143, 0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class VoteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  void _gemma() async {
    var resp = await _sendNotification(true);
    print("Response body: ${resp.body}");

    setState(() {
      jona = resp.body;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResultScreen()));
    });
  }

  void _gemmaNed() async {
    var resp = await _sendNotification(false);
    print("Response body: ${resp.body}");

    setState(() {
      jona = resp.body;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResultScreen()));
    });
  }

  Future<Response> _sendNotification(bool gemma) {
    return Client().post(
      Uri.http("172.17.77.118:8888", ""),
      body: "vote§"+(gemma ? "jo\n" : "na\n"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBackgroundWidget(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: _gemma,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              child: Text(
                "Jo",
                textScaleFactor: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Marlboro",
                  fontSize: 35,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _gemmaNed,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              child: Text(
                "Na",
                textScaleFactor: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Marlboro",
                  fontSize: 35,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getBackgroundWidget(
      Text("Es woin " +
          jona.split(";").first +
          " geh und " +
          jona.split(";").last +
          " ned"),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemma Rauchn',
      home: Scaffold(
        /*appBar: AppBar(
          title: Text('Gemma Rauchn'),
        ),*/
        body: MainScreen(),
      ),
    );
  }
}
/*Image.asset(
                  'images/heart.jpg',
                  width: 400.0,
                  height: 400.0,
                  fit: BoxFit.contain,
                ),*/
