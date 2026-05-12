import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedcategory = "Wisdom";
  String? quotes, author;

  Future<void> fetchquote(String category) async {
    final response = await http.get(
      Uri.parse("https://api.api-ninjas.com/v2/quotes?categories=$category"),
      headers: {
        "Content-Type": "application-json",
        "X-Api-Key": "i5JtaD3dLzzEi0TOezUeA1Aiu127tKVjd6zqPz0L",
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsondata = jsonDecode(response.body);
      if (jsondata.isNotEmpty) {
        Map<String, dynamic> thatquotes = jsondata[0];
        quotes = thatquotes["quote"];
        author = thatquotes["author"];
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    fetchquote("wisdom");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/wooden-background.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 50),
                child: Text(
                  "Quotify",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(height: 100),
                    buildcategories("Wisdom"),
                    buildcategories("Philosophy"),
                    buildcategories("Life"),
                    buildcategories("Truth"),
                    buildcategories("Love"),
                  ],
                ),
              ),
              SizedBox(height: 70),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: MediaQuery.of(context).size.height / 2,

                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 100),
                      child: Text(
                        quotes ?? "Loading..",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 140, top: 20),
                      child: Text(
                        author ?? "Loading..",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "pacifico",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildcategories(String title) {
    bool isselected = selectedcategory == title;
    return GestureDetector(
      onTap: () {
        fetchquote(title);
        setState(() {
          selectedcategory = title;
        });
      },
      child: Container(
        height: 50,
        width: 100,
        margin: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: isselected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isselected ? Colors.red : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
