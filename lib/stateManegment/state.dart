import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'DataModel.dart';

@immutable
abstract class AppState{
  AppState();
}

class LoadingData extends AppState{
  LoadingData();
}

class DataLoaded extends AppState{
  final List<RandomUser> users;
  DataLoaded({required this.users});
}
class DataNotLoaded extends AppState{
  DataNotLoaded();
}

@immutable
abstract class AppEvent{}

class LoadData extends AppEvent{}

class InventoryBloc extends Bloc<AppEvent,AppState>{
  final Dio _dio = Dio();
  final String url = 'https://randomuser.me/api/?page=1&results=10';

  InventoryBloc() : super(LoadingData()){
    on<AppEvent>((event, emit) async {
      try {
        Response response = await _dio.get(url);

        if (response.statusCode == 200) {
          // Parse the response to a list of RandomUser objects
          List<dynamic> results = response.data['results'];
          List<RandomUser> users = results.map((json) => RandomUser.fromJson(json)).toList();

          print("Fetched ${users.length} users.");

          emit(DataLoaded(users: users));
        } else {
          print("Failed to fetch data: ${response.statusCode}");
          emit(DataNotLoaded());
        }
      } catch (e) {
        print("Error occurred: $e");
        emit(DataNotLoaded());
        }
      }
    );
  }
}
