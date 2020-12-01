import 'package:flutter/material.dart';
import 'package:flutter_app_1/service/http_service.dart';

class ImagesFromNetwork extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImagesFromNetworkState();
}

class ImagesFromNetworkState extends State<ImagesFromNetwork> {
  Future<List<Image>> _images;
  final HttpService _httpService = HttpService();

  @override
  void initState() {
    super.initState();
    _initList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Image>>(
        future: _images,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? _getImages(snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  _getImages(List<Image> data) {
    return RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _initList();
          });
        },
//        child: ListView.separated(
//          padding: const EdgeInsets.all(8),
//          itemCount: data.length,
//          itemBuilder: (BuildContext context, index) {
//            return data[index];
//          },
//          separatorBuilder: (BuildContext context, int index) =>
//          const Divider(),
//        ),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: data,
        ));
  }

  void _initList() async {
    _images = _httpService.getImages("bmw");
  }
}
