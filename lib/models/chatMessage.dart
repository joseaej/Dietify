enum ChatmessageEnum { user, bot }

class ChatMessage {
  final String message;
  final ChatmessageEnum chatmessageEnum;
  ChatMessage({required this.message, required this.chatmessageEnum});
}
