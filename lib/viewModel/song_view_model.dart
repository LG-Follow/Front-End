// 서버와 연결하여, 사용자가 만든 그림, 노래 정보를 받아오는 기능
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import '../model/song.dart';

class SongViewModel extends ChangeNotifier {
  List<Song> _songs = [];
  Song? _currentSong;
  String? _currentSongImage; // 마지막 선택된 이미지 URL 유지
  bool _isPlaying = false;
  bool _isLoading = true;

  final AudioPlayer _audioPlayer = AudioPlayer(); // 오디오 플레이어 인스턴스
  final String? baseUrl = dotenv.env['BASEURL'];

  Uri _buildUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  List<Song> get songs => _songs;
  Song? get currentSong => _currentSong;
  String? get currentSongImage => _currentSongImage;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;

  SongViewModel() {
    fetchSongs();
  }

  // 서버에서 노래 및 그림 목록을 가져오는 함수
  Future<void> fetchSongs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = _buildUri('/song/user/1');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = json.decode(response.body);

        // 서버에서 받은 데이터 매핑
        _songs = data.map((json) => Song.fromJson(json)).toList();
        _songs.sort((a, b) => a.createdAt.compareTo(b.createdAt)); // 정렬
      } else {
        throw Exception('Failed to load songs');
      }
    } catch (e) {
      print("Failed to fetch songs: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 노래 선택 및 서버에 재생 요청
  Future<void> selectSong(Song song, String imageUrl) async {
    _currentSong = song;
    _currentSongImage = imageUrl;

    // 서버에 재생 요청
    try {
      final url = _buildUri('/song/play/20');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // 기존 재생 중인 노래 정지
        await _audioPlayer.stop();
        // 새 노래 재생
        await _audioPlayer.play(UrlSource(song.songUrl));
        _isPlaying = true;
      } else {
        throw Exception('Failed to play song');
      }
    } catch (e) {
      print("Failed to play song: $e");
    }

    notifyListeners();
  }

  // 재생/일시정지 상태를 토글하는 함수
  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _isPlaying = false;
    } else {
      await _audioPlayer.resume();
      _isPlaying = true;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
