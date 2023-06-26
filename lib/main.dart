import 'package:flutter/material.dart';
import 'package:parallax_effect/video_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'Parallax Videos',
        debugShowCheckedModeBanner: false,
        home: VideosScreen(),
      );
}

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController( viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
const videos = [
  'assets/video1.mp4',
  'assets/video2.mp4',
  'assets/video1.mp4',
  'assets/video2.mp4',
  'assets/video1.mp4',
];

    return Scaffold(
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _selectedIndex = i),
              itemCount: videos.length,
              itemBuilder: (context, index) => VideoCard(
                assetPath: videos[index],
                isSelected: _selectedIndex == index,
              ),
            ),
          ),
        ),
      );
  }
}
