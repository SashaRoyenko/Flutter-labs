import 'package:mongo_dart/mongo_dart.dart';
class DBConnection {

  static DBConnection _instance;

  static final String _host = "";
  static final String _port = "27017";
  static final String _dbName = "flutter";
  static final String _dbUser = "admin";
  static final String _dbPassword = "admin";

  Db _db;

  static getInstance(){
    if(_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async{
    if (_db == null){
      try {
        _db = await Db.create(getConnectionString());
        await _db.open();
      } catch(e){
        print(e);
      }
    }
    return _db;
  }

  static String getConnectionString(){
//    return "mongodb://$_host:$_port/$_dbName";
    return 'mongodb://$_dbUser:$_dbPassword@$_host:$_port,myclaster-shard-00-01.qe5xc.mongodb.net:27017,myclaster-shard-00-02.qe5xc.mongodb.net:27017/$_dbName?ssl=true&replicaSet=atlas-c9kbsh-shard-0&authSource=admin&retryWrites=true&w=majority';
//    return 'mongodb+srv://$_dbUser:$_dbPassword@$_host:$_port/$_dbName?retryWrites=true&w=majority';
  }

  closeConnection() {
    _db.close();
  }

}