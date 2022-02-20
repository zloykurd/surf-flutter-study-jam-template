import 'package:core/models/dtos/message/chat_message_dto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/config/app_configuration.dart';
import 'package:surf_practice_chat_flutter/extensions/string_extensions.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/main_view_model.dart';
import 'package:surf_practice_chat_flutter/presentation/widgets/list_items/chat_message_widget.dart';
import 'package:surf_practice_chat_flutter/presentation/widgets/not_network_connection_widget.dart';
import 'package:surf_practice_chat_flutter/resources/strings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<MainViewModel>();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: model.inProgress() ? _progress() : _messages(model.getItems()),
        ),
      ),
    );
  }

  Widget _messages(List<ChatMessageDto> items) {
    if (items.isEmpty) {
      var title = _setText(Strings.message_list_is_empty);
      return Text(
        title,
        style: const TextStyle(color: Colors.black),
      );
    }
    var appConfig = context.read<AppConfiguration>();
    if (!appConfig.hasInternetConnection) {
      return const NotNetworkConnectionWidget();
    }

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final model = items[index];
          return ChatMessageWidget(
            model: model,
          );
        });
  }

  Widget _progress() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  String _setText(String key) {
    return key.getName(context, key) ?? "";
  }

  void _loadData() async {
    var model = context.read<MainViewModel>();
    await model.updateChatListAsync();
  }
}
