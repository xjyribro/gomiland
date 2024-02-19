import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/profile/utils.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/utils/firestore.dart';

class RequestFriendRow extends StatefulWidget {
  final int? index;
  final String name;
  final String country;
  final String daysInGame;
  final String? otherPlayerId;
  final bool isSendRequest;

  const RequestFriendRow({
    super.key,
    this.index,
    this.otherPlayerId,
    required this.name,
    required this.country,
    required this.daysInGame,
    required this.isSendRequest,
  });

  @override
  State<RequestFriendRow> createState() => _RequestFriendRowState();
}

class _RequestFriendRowState extends State<RequestFriendRow> {
  bool _isLoading = false;

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _sendFriendRequest(BuildContext context) async {
    if (_isLoading) return;
    _setIsLoading(true);
    String playerId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String receiverId = widget.otherPlayerId!;
    await sendFriendRequest(senderId: playerId, receiverId: receiverId)
        .then((success) {
      if (success) {
        updateFriendRequestSentList(context, receiverId);
      } else {
        Popups.showMessage(
            context: context, title: 'Sending request failed', subTitle: '');
      }
    });
    _setIsLoading(false);
  }

  Future<void> _acceptFriendRequest(BuildContext context) async {
    if (_isLoading) return;
    _setIsLoading(true);
    String playerId = FirebaseAuth.instance.currentUser?.uid ?? '';
    await sendFriendRequest(senderId: playerId, receiverId: widget.otherPlayerId!)
        .then((success) {
      if (!success) {
        Popups.showMessage(
            context: context, title: 'Sending request failed', subTitle: '');
      }
    });
    _setIsLoading(false);
  }

  Widget _getButton({
    required BuildContext context,
    required bool isSendRequest,
  }) {
    if (isSendRequest) {
      return BlocBuilder<PlayerStateBloc, PlayerState>(
          builder: (context, state) {
        List<String> friendRequestsSent = state.friendRequestsSent;
        bool hasSentRequest =
            isSendRequest && friendRequestsSent.contains(widget.otherPlayerId);
        return MenuButton(
          onPressed: hasSentRequest
              ? null
              : () async {
                  await _sendFriendRequest(context);
                },
          text: hasSentRequest ? 'Friend request sent' : 'Send friend request',
          style: hasSentRequest
              ? TextStyles.sendFriendRequestRedTextStyle
              : TextStyles.sendFriendRequestTextStyle,
          isLoading: _isLoading,
        );
      });
    }
    return MenuButton(
      onPressed: () async {
        await _acceptFriendRequest(context);
      },
      text: 'Accept friend request',
      style: TextStyles.sendFriendRequestTextStyle,
      isLoading: _isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              widget.index != null ? widget.index.toString() : '',
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              widget.name,
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              widget.country,
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              widget.daysInGame,
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
          Expanded(
            flex: 3,
            child: widget.otherPlayerId != null
                ? _getButton(
                    context: context,
                    isSendRequest: widget.isSendRequest,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
