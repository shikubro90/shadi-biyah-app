import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/view/widget/messeging_feature/audio_player/audio_player_controller.dart';

class MyAudioPlayer extends StatefulWidget {
  final String message;
  final bool isCurrentUser;
  final int index;
  const MyAudioPlayer({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.index,
  });

  @override
  State<MyAudioPlayer> createState() => _MyAudioPlayerState();
}

class _MyAudioPlayerState extends State<MyAudioPlayer> {
  final audioController = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              audioController.onPressedPlayButton(widget.index, widget.message);
              // changeProg(duration: duration);
            },
            onSecondaryTap: () {
              //   audioController.completedPercentage.value = 0.0;
            },
            child: Obx(
              () => (audioController.isRecordPlaying &&
                      audioController.currentId == widget.index)
                  ? Icon(
                      Icons.pause,
                      color: widget.isCurrentUser
                          ? AppColors.pink100
                          : AppColors.pink60,
                    )
                  : Icon(
                      Icons.play_arrow,
                      color: widget.isCurrentUser
                          ? AppColors.pink100
                          : AppColors.pink60,
                    ),
            ),
          ),
          Obx(
            () => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Text(audioController.completedPercentage.value.toString(),style: TextStyle(color: Colors.white),),
                    LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          widget.isCurrentUser
                              ? AppColors.red80
                              : AppColors.red80),
                      value: (audioController.isRecordPlaying &&
                              audioController.currentId == widget.index)
                          ? audioController.completedPercentage.value
                          : audioController.totalDuration.value.toDouble(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          // Text(
          //   // audioController.totalDuration.value.toString(),
          //   Duration(microseconds: audioController.totalDuration.value)
          //       .toString()
          //       .split('.')[0],
          //   style: const TextStyle(fontSize: 12, color: AppColors.black60),
          // ),
        ],
      ),
    );
  }
}
