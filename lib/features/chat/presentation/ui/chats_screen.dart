import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/di/dependency_injection.dart';
import 'package:pulse/core/helpers/extensions.dart';
import 'package:pulse/core/routing/routes.dart';
import 'package:pulse/core/widgets/app_indicator.dart';
import 'package:pulse/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:pulse/features/chat/data/user_model.dart';
import 'package:pulse/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:pulse/features/chat/presentation/ui/widgets/my_drawer.dart';
import 'package:pulse/features/chat/presentation/ui/widgets/user_list_title.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<UserModel>? _cachedUsers;

  @override
  void initState() {
    super.initState();

    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    await getIt<ChatCubit>().fetchAllUsersExceptBlocked();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = getIt<AuthCubit>().getCurrentUser()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser.displayName!),
      ),
      drawer: const MyDrawer(),
      // Use a BlocListener to update the cached list on state changes.
      body: BlocListener<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatUserBlockedSuccessfulState) {
            // If a block event occurs, re-fetch users.
            getIt<ChatCubit>().fetchAllUsersExceptBlocked();
          } else if (state is ChatsUsersExceptBlockedLoadedState) {
            // Update local cache and rebuild.
            _cachedUsers = state.users;
            setState(() {});
          }
        },
        child: _cachedUsers == null
            ? const Center(child: AppIndicator())
            : _buildUserList(context, _cachedUsers!, currentUser.uid),
      ),
    );
  }

  Widget _buildUserList(
      BuildContext context, List<UserModel> users, String currentUserUid) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        if (user.uid == currentUserUid) return const SizedBox.shrink();
        return UserListTile(
          user: user,
          onTap: () async {
            context.navigateToNamed(Routes.chatRoomScreen, arguments: user);
          },
        );
      },
    );
  }
}
