import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

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
  ScrollController scrollController2 = ScrollController();
  ScrollController scrollController3 = ScrollController();

  @override
  void initState() {
    super.initState();

    apiCall();
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
        body: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: mapResponse['data'] == null
                        ? const Text('Data is Loading')
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
                  const Positioned(
                    top: 80,
                    right: 20,
                    child: Text('Scroll Indicator',
                        style: TextStyle(color: Colors.white)),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 20,
                    child: Text(mapResponse['data']['title'],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(28.0),
                color: const Color(0xFFFFF8DA),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mapResponse['data']['components'][1]['title'],
                      style: const TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      mapResponse['data']['components'][1]['desc'],
                      style: const TextStyle(color: Colors.black, fontSize: 23),
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
      ),
    );
  }
}
