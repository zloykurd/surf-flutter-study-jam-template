import 'package:core/models/dtos/message/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/states/base_state.dart';

class MainViewState extends BaseState {
  final List<ChatMessageDto> items;

  MainViewState({
    required this.items,
    bool isLoading = false,
    String error = "",
  }) : super(isLoading: isLoading, error: error);

  MainViewState copyWith({
    List<ChatMessageDto>? items,
    String? error,
    bool? isLoading,
  }) {
    return MainViewState(
        items: items ?? this.items,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }
}
