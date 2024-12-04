import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/song_view_model.dart';
import '../model/song.dart';

class SongListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '빠른 선곡',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<SongViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (viewModel.songs.isEmpty) {
                  return Center(
                    child: Text(
                      '노래를 불러오지 못했습니다. 다시 시도해주세요.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: viewModel.songs.length,
                  itemBuilder: (context, index) {
                    Song song = viewModel.songs[index];
                    String imageUrl = song.imageUrl;

                    return GestureDetector(
                      onTap: () {
                        if (song.songUrl.isNotEmpty && imageUrl.isNotEmpty) {
                          viewModel.selectSong(song, imageUrl);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              imageUrl,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
                              },
                            ),
                            SizedBox(height: 8),
                            Text(
                              song.title,
                              style: TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${song.duration.inMinutes}:${(song.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Consumer<SongViewModel>(
            builder: (context, viewModel, child) => _buildBottomBar(viewModel),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: '디스커버'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: '리포트'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: '메뉴'),
        ],
      ),
    );
  }

  Widget _buildBottomBar(SongViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (viewModel.currentSongImage != null)
            Image.network(
              viewModel.currentSongImage!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
              },
            )
          else
            SizedBox(width: 50, height: 50),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                viewModel.currentSong?.title ?? '선택된 곡 없음',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                viewModel.isPlaying ? '재생 중' : '일시정지',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(viewModel.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.black),
            onPressed: viewModel.togglePlayPause,
          ),
        ],
      ),
    );
  }
}
