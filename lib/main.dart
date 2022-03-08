import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import 'package:images/model.dart';

void main() {
  runApp(ImageDisplay());
}

class ImageDisplay extends StatefulWidget {
  ImageDisplay({Key? key}) : super(key: key);

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  int counter = 0;
  List<ImageModel> images = [];
  void fetchImage() async {
    counter++;
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/photos/$counter');
    var response = await get(uri);
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_a_photo),
          onPressed: fetchImage,
        ),
        appBar: AppBar(
          title: Text('Image Gallery'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, int index) {
            return Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color:Colors.blueAccent,style: BorderStyle.solid,width: 3),
              ),
              child: Column(
                children: [
                  Image.network(images[index].url),
                    Text("Image Id : ${images[index].id.toString()}"),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(images[index].title)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
