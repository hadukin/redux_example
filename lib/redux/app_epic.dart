part of 'app_store.dart';

Epic<AppState> _createAppEpic() {
  return combineEpics<AppState>([
    todoEpics,
    authEpics,
    // Другие эпики...
  ]);
}
