
import 'local_data_source.dart';
import 'login_repozitory.dart';

late final UserRepository localRepository;
Future<void> serviceLocatorLocal()async{
  final db = await LocalDataSourceImpl.init;
  LocalDataSource loginSource = LocalDataSourceImpl(db: db);
  localRepository = UserRepositoryImplements(dataSource: loginSource);
}