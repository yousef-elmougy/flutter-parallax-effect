import 'package:flutter/material.dart';
import 'package:parallax_effect/parallax_effect/horizontal_parallax_effect.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({
    super.key,
    required this.assetPath,
    required this.isSelected,
  });

  final String assetPath;
  final bool isSelected;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  final GlobalKey _videoKey = GlobalKey();

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) => setState(() => _checkSelectedVideo()));
  }

  void _checkSelectedVideo() {
    if (widget.isSelected) {
      _controller
        ..play()
        ..setLooping(true);
    } else {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      _checkSelectedVideo();
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: widget.isSelected
            ? const EdgeInsets.symmetric(vertical: 16, horizontal: 4)
            : const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 6),
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Flow(
            delegate: HorizontalParallaxEffect(
              scrollable: Scrollable.of(context),
              listItemContext: context,
              backgroundImageKey: _videoKey,
            ),
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                  key: _videoKey,
                ),
              ),
            ],
          ),
        ),
      );
}
