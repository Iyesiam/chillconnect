import 'package:flutter/material.dart';

class ChatroomPage extends StatefulWidget {
  final List<Comment> comments;

  ChatroomPage({required this.comments});

  @override
  _ChatroomPageState createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  List<Comment> filteredComments = [];
  TextEditingController _searchController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    filteredComments = widget.comments;
    _searchController.addListener(_filterComments);
  }

  void _filterComments() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredComments = widget.comments.where((comment) {
        return comment.text.toLowerCase().contains(query) ||
            comment.author.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        widget.comments.add(Comment(
          text: _commentController.text,
          author: 'Current User',
          date: DateTime.now().toString(),
          profilePicUrl: 'https://example.com/profile-pic-url', // Replace with actual URL
        ));
        _commentController.clear();
        filteredComments = widget.comments; // Update filtered comments

        // Scroll to the bottom of the list
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatroom'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: filteredComments.length,
              itemBuilder: (context, index) {
                final comment = filteredComments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(comment.profilePicUrl),
                  ),
                  title: Text(comment.author),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.text),
                      SizedBox(height: 5),
                      Text(
                        _formatDate(comment.date),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Add a comment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String text;
  final String author;
  final String date;
  final String profilePicUrl;

  Comment({
    required this.text,
    required this.author,
    required this.date,
    required this.profilePicUrl,
  });
}
