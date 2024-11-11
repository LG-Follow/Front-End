import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/song.dart';

class SongViewModel extends ChangeNotifier {
  List<Song> _songs = [];
  Song? _currentSong;
  String? _currentSongImage; // 마지막 선택된 이미지 URL 유지
  bool _isPlaying = false;
  bool _isLoading = true;

  List<Song> get songs => _songs;
  Song? get currentSong => _currentSong;
  String? get currentSongImage => _currentSongImage;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;

  SongViewModel() {
    fetchSongs();
  }

  // 서버에서 노래 목록을 가져오는 함수
  Future<void> fetchSongs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = dotenv.env['SERVER_URL'];
      if (url != null) {
        final response = await http.get(Uri.parse('$url/songs'));
        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          _songs = data.map((json) => Song.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load songs');
        }
      } else {
        throw Exception('Server URL not found in .env');
      }
    } catch (e) {
      print("Failed to fetch songs: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 노래 선택 및 재생 상태 변경
  void selectSong(Song song, String imageUrl) {
    _currentSong = song;
    _currentSongImage = imageUrl;
    _isPlaying = true;
    notifyListeners();
  }

  // 재생/일시정지 상태를 토글하는 함수
  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }
}
