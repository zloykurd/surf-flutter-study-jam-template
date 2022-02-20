import 'package:core/contracts/repositories/chat_repository.dart';
import 'package:core/models/dtos/message/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/base_view_model.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/states/main_view_state.dart';

class MainViewModel extends BaseViewModel {
  late MainViewState _state;
  final ChatRepository _repository;

  MainViewModel(this._repository) {
    _state = MainViewState(items: []);
  }

  Future<void> _loadData() async {
    var messages = await _repository.messages;
    _state = _state.copyWith(items: messages);
    notifyListeners();
  }

  List<ChatMessageDto> getItems() {
    return _state.items;
  }

  bool hasItems() {
    return _state.items.isNotEmpty;
  }

  bool inProgress() {
    return _state.isLoading;
  }

  Future<void> updateChatListAsync() async {
    await _loadData();
  }
}
