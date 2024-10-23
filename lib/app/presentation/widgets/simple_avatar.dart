import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/user/user_bloc.dart';

class SimpleAvatar extends StatelessWidget {
  const SimpleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserBloc>().state;
    bool isLoading = userState.loading;

    return isLoading
        ? const SkeletonAvatar(
            style: SkeletonAvatarStyle(
              shape: BoxShape.circle,
              width: 20,
              height: 20,
            ),
          )
        : userState.user.avatar != null
            ? CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).hintColor,
                // backgroundImage: Image.network(
                //   userState.user.avatar ?? '',
                //   fit: BoxFit.cover,
                // ).image,
                backgroundImage: CachedNetworkImageProvider(
                  userState.user.avatar ?? '',
                ),
              )
            : const Icon(Icons.person_2_outlined, size: 30.0);
  }
}
