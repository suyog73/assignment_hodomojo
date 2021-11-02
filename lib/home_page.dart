import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:scroll_indicator/scroll_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// String apiData = '';
Map mapResponse = {};

const apiUrl =
    'http://website-bucket-12234.s3-website-us-east-1.amazonaws.com/api.json';

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    apiCall();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        // apiData = response.body;
        mapResponse = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 420,
                          alignment: Alignment.center,
                          child: mapResponse['data'] == null
                              ? fadingCircle
                              : Image.network(
                                  mapResponse['data']['components'][0]['url']
                                      .toString(),
                                  // height: MediaQuery.of(context).size.height,
                                  // width: MediaQuery.of(context).size.width,
                                  // fit: BoxFit.fill,
                                ),
                        ),
                        const Positioned(
                          top: 50,
                          left: 20,
                          child: Icon(
                            Icons.padding,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 20,
                          child: mapResponse['data'] == null
                              ? fadingCircle
                              : Text(mapResponse['data']['title'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22)),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(28.0),
                      color: const Color(0xFFFFF8DA),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mapResponse['data'] == null
                              ? fadingCircle
                              : Text(
                                  mapResponse['data']['components'][1]['title'],
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                          const SizedBox(height: 20.0),
                          mapResponse['data'] == null
                              ? fadingCircle
                              : Text(
                                  mapResponse['data']['components'][1]['desc'],
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 23),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(FontAwesomeIcons.joomla),
                              SizedBox(width: 10),
                              Text(
                                'Zostel',
                                style: TextStyle(fontSize: 26),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'What a peaceful picture it is!',
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/random.jpg"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: null /* add child content here */,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: 10,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    height: 20,
                    width: 150,
                    color: Colors.transparent,
                    child: ScrollIndicator(
                      scrollController: scrollController,
                      indicatorWidth: 30,
                      width: 90,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.grey[500]),
                      indicatorDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final fadingCircle = SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.lightBlue : Colors.blue,
      ),
    );
  },
);
