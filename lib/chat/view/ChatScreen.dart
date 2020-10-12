import 'package:Radar/chat/model/Message.dart';
import 'package:Radar/requests/controller/RequestsController.dart';
import 'package:Radar/chat/view/ChatInput.dart';
import 'package:Radar/chat/view/ChatItem.dart';
import 'package:Radar/chat/view/ChatAppBar.dart';
import 'package:Radar/utils/DisconnectedDialog.dart';
import 'package:Radar/utils/Role.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:Radar/utils/ConnectionState.dart' as util;

class ChatScreen extends StatelessWidget {
  final _schedulerBinding = SchedulerBinding.instance;
  @override
  Widget build(BuildContext context) {
    final _routeName = ModalRoute.of(context).settings.name;
    Role _role;

    return Consumer<RequestsController>(
      builder: (context, _requestsController, child) {
        ScrollController _scrollController = ScrollController();

        if (_routeName == '/requestAccepterChat') {
          _role = _requestsController.roles.requestAccepter;
        } else {
          _role = _requestsController.roles.requestCreater;
        }

        if (_role.connectionState != util.ConnectionState.Connected && _role.shownDisconnectedDialog == false) {
          _schedulerBinding.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => DisconnectedDialog(),
            ).whenComplete(() {
              if (_routeName == '/requestAccepterChat') {
                _requestsController.roles.requestAccepter.shownDisconnectedDialog = true;
              } else {
                _requestsController.roles.requestCreater.shownDisconnectedDialog = true;
              }
              Navigator.of(context).popUntil(
                ModalRoute.withName('/home'),
              );
            });
            return Container();
          });
        }

        _schedulerBinding.addPostFrameCallback((_) {
          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
        });

        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    ChatAppBar(
                      title: _role.requestTitle,
                      description: _role.requestDescription,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(10),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int i) => ChatItem(
                            message: _role.messages[i],
                          ),
                          childCount: _role.messages.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ChatInput(
                sendMessage: _role.sendMessage,
              ),
            ],
          ),
        );
      },
    );
  }
}
