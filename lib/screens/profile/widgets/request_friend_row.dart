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
  final bool? isSendRequest;

  const RequestFriendRow({
    super.key,
    this.index,
    this.otherPlayerId,
    this.isSendRequest,
    required this.name,
    required this.country,
    required this.daysInGame,
  });

  @override
  State<RequestFriendRow> createState() => _RequestFriendRowState();
}

class _RequestFriendRowState extends State<RequestFriendRow> {
  bool _isLoading = false;
  bool _isAccepted = false;

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setIsAccepted(bool isAccepted) {
    setState(() {
      _isAccepted = isAccepted;
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
          context: context,
          title: 'Sending request failed',
          subTitle: '',
        );
      }
    });
    _setIsLoading(false);
  }

  Future<void> _acceptFriendRequest(BuildContext context) async {
    if (_isLoading) return;
    _setIsLoading(true);
    String playerId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String senderId = widget.otherPlayerId!;
    await acceptFriendRequest(senderId: senderId, receiverId: playerId)
        .then((success) {
      if (success) {
        onAcceptFriendRequest(context, senderId);
        _setIsAccepted(true);
      } else {
        Popups.showMessage(
          context: context,
          title: 'Accept request failed',
          subTitle: '',
        );
      }
    });
    _setIsLoading(false);
  }

  Widget _getButton(BuildContext context) {
    if (widget.isSendRequest == null) return Container();
    bool isSendRequest = widget.isSendRequest!;
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
      onPressed: _isAccepted
          ? null
          : () async {
              await _acceptFriendRequest(context);
            },
      text: _isAccepted ? 'Accepted!' : 'Accept',
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
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                widget.name,
                style: TextStyles.menuWhiteTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                widget.country,
                style: TextStyles.menuWhiteTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                widget.daysInGame,
                style: TextStyles.menuWhiteTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: widget.otherPlayerId != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: _getButton(context),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
