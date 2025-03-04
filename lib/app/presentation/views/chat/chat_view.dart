import 'package:el_vaso/app/presentation/widgets/custom_appbar_home.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      // drawer: const CustomDrawer(),
      appBar: CustomAppbarHome(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(child: SingleChildScrollView(child: Text('Chat View'))),
      ),
    );
  }
}
