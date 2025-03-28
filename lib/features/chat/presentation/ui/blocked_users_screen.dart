import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/di/dependency_injection.dart';
import 'package:pulse/core/widgets/app_indicator.dart';
import 'package:pulse/core/widgets/show_custom_toast.dart';
import 'package:pulse/features/chat/data/user_model.dart';
import 'package:pulse/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:pulse/features/chat/presentation/ui/widgets/blocked_user_tile.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../generated/l10n.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({Key? key}) : super(key: key);

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  List<UserModel>? _blockedUsers;

  @override
  void initState() {
    super.initState();
    // Initially load blocked users.
    _loadBlockedUsers();
  }

  Future<void> _loadBlockedUsers() async {
    await getIt<ChatCubit>().getBlockedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).blockedUsers),
      ),
      body: BlocProvider.value(
        value: getIt<ChatCubit>(),
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is ChatBlockedUsersLoadedState) {
              setState(() {
                _blockedUsers = state.blockedUsers;
              });
            } else if (state is ChatUserUnblockedSuccessfulState) {
              showToast(
                message: S
                    .of(context)
                    .unblockedSuccess(state.user.name.split(" ")[0]),
                color: AppColors.toastSuccessColor,
              );
            } else if (state is ChatUserUnblockedErrorState) {
              showToast(message: state.error, color: AppColors.toastErrorColor);
              // Optionally re-load the list.
              _loadBlockedUsers();
            }
          },
          builder: (context, state) {
            if (_blockedUsers == null) {
              return const Center(child: AppIndicator());
            }
            if (_blockedUsers!.isEmpty) {
              return Center(
                child: Text(
                  S.of(context).noBlockedUsers,
                  style: TextStyles.font16Regular,
                ),
              );
            }
            return ListView.builder(
              itemCount: _blockedUsers!.length,
              itemBuilder: (context, index) {
                final user = _blockedUsers![index];
                return BlockedUserTile(
                  user: user,
                  onTap: () async {
                    // Optimistically remove this user from the local list.
                    setState(() {
                      _blockedUsers!.removeAt(index);
                    });
                    // Call unblock. In case of error, you could decide to re-add the user.
                    await getIt<ChatCubit>().unblockUser(userId: user.uid);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
