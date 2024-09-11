import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class DoctorChatPage extends StatefulWidget {
  final String doctorId;
  final String doctorName;

  DoctorChatPage({required this.doctorId, required this.doctorName});

  @override
  _PatientChatPageState createState() => _PatientChatPageState();
}

class _PatientChatPageState extends State<DoctorChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? _imageFile;
  bool _isTextFieldFocused = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        _isTextFieldFocused = _messageController.text.isNotEmpty;
      });
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final userName = currentUser.displayName ?? "Anonymous";
        final userId = currentUser.uid;
        await _firestore
            .collection('chats')
            .doc(widget.doctorId)
            .collection('messages')
            .add({
          "sendby": userName,
          "sendbyId": userId,
          "message": _messageController.text,
          "type": "text",
          "time": FieldValue.serverTimestamp(),
        });
        _messageController.clear();
        _scrollToBottom();
      } else {
        print("No current user logged in");
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref().child('images').child(fileName);
      await reference.putFile(_imageFile!);
      String downloadUrl = await reference.getDownloadURL();

      await _firestore
          .collection('chats')
          .doc(widget.doctorId)
          .collection('messages')
          .add({
        "sendby": _auth.currentUser?.displayName ?? "Anonymous",
        "sendbyId": _auth.currentUser?.uid ?? "Anonymous",
        "message": downloadUrl,
        "type": "image",
        "time": FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile_placeholder.png'),
            ),
            SizedBox(width: 10),
            Text(widget.doctorName),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chats')
                  .doc(widget.doctorId)
                  .collection('messages')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final map = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                      return _buildMessage(size, map);
                    },
                  );
                } else {
                  return Center(child: Text("No messages yet"));
                }
              },
            ),
          ),
          _buildMessageInput(size),
        ],
      ),
    );
  }

  Widget _buildMessage(Size size, Map<String, dynamic> map) {
    final isCurrentUser = map['sendbyId'] == _auth.currentUser?.uid;
    final messageColor = isCurrentUser ? Colors.green : Colors.yellow;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!isCurrentUser)
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/user_placeholder.png'), // Placeholder for doctor profile image
                  ),
                SizedBox(width: 10),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: messageColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: map['type'] == 'image'
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowImage(imageUrl: map['message']),
                                ),
                              );
                            },
                            child: Image.network(map['message']),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                map['sendby'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                map['message'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              map['time'] != null
                  ? DateFormat('h:mm a').format((map['time'] as Timestamp).toDate())
                  : "Sending...",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Send Message...",
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.photo, color: Colors.blueAccent),
            onPressed: _pickImage,
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blueAccent),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  ShowImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image"),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
