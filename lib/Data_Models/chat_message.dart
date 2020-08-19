class ChatMessage
{
  String id;
  String posterId;
  String posterDisplayName;
  String content;

  ChatMessage(this.id, this.posterId, this.posterDisplayName, this.content);

  factory ChatMessage.fromJson(Map<String, dynamic> data)
  {
    return new ChatMessage(data["id"], data["posterId"], data["posterDisplayName"], data["content"]);
  }
}