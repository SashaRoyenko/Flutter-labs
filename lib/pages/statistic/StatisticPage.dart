import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/entity/ClickStatistic.dart';
import 'package:flutter_app_1/service/ClickStatisticService.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;

class StatisticPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _StatisticPageState();

}

class _StatisticPageState extends State<StatisticPage> {

  Future<List<ClickStatistic>> _clickStatisticList;
  final ClickStatisticService _clickStatisticService = ClickStatisticService();

  @override
  void initState() {
    super.initState();
    _initList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ClickStatistic>>(
        future: _clickStatisticList,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? _getCard(snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget _getCard(List<ClickStatistic> data) {
    return RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _initList();
          });
        },
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: data.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
                child: Column(children: <Widget>[
                  Tooltip(
                      message: _getTooltipMessage(data[index]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        color: data[index].backgroundColor,
                        child: Center(
                            child: Text(
                          _formatDate(data[index].dateTime),
                          style: TextStyle(
                              color: data[index].buttonColor, fontSize: 24),
                        )),
                      )),
                  IconButton(
                    onPressed: () => _deleteClickStatistic(data[index].id),
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  )
            ]));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }

  void _initList() async {
    _clickStatisticList = _clickStatisticService.getAll();
  }

  String _formatDate(DateTime datetime) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');
    return formatter.format(datetime);
  }

  void _deleteClickStatistic(ObjectId id) {
    setState(() {
      _clickStatisticService.delete(id);
      _initList();
    });
  }

  String _getTooltipMessage(ClickStatistic data) {
    return "background: ${data.backgroundColor};\n"
        "button: ${data.buttonColor};";
  }
}
