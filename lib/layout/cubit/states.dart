abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

class GetDataSuccessState extends NewsState {}

class GetDataErrorState extends NewsState {
  final String error;

  GetDataErrorState(this.error);
}

class GetDataLoadingState extends NewsState {}

class GetSportsDataSuccessState extends NewsState {}

class GetSportsDataErrorState extends NewsState {
  final String error;

  GetSportsDataErrorState(this.error);
}

class GetSportsDataLoadingState extends NewsState {}

class GetScienceDataSuccessState extends NewsState {}

class GetScienceDataErrorState extends NewsState {
  final String error;

  GetScienceDataErrorState(this.error);
}

class GetScienceDataLoadingState extends NewsState {}

class SearchDataSuccessState extends NewsState {}

class SearchDataErrorState extends NewsState {
  final String error;

  SearchDataErrorState(this.error);
}

class SearchDataLoadingState extends NewsState {}

abstract class AppState {}

class AppInitialState extends AppState {}

class ChangeAppModeState extends AppState {}
