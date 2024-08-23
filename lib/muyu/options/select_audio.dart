import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/muyu/models/audio_option.dart';

class AudioOptionPanel extends StatelessWidget {
  final List<AudioOption> audioOptions;
  final int activeIndex;
  final ValueChanged<int> onSelect;

  const AudioOptionPanel(
      {super.key,
      required this.audioOptions,
      required this.activeIndex,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return Material(
        child: SizedBox(
      height: 300,
      child: Column(children: [
        Container(
          height: 46,
          alignment: Alignment.center,
          child: const Text('选择音频', style: labelStyle),
        ),
        ...List.generate(audioOptions.length, _buildByIndex)
      ]),
    ));
  }

  Widget _buildByIndex(int index) {
    bool active = index == activeIndex;
    final option = audioOptions[index];
    return ListTile(
      title: Text(option.name),
      selected: active,
      onTap: () {
        onSelect(index);
      },
      trailing: IconButton(onPressed: ()=> _tempPlay(option.src), icon: const Icon(
        Icons.record_voice_over_rounded,
        color: Colors.blue,
      )),
    );

  }

  void _tempPlay(String src) async{
    AudioPool pool = await FlameAudio.createPool(src, maxPlayers: 1);
    pool.start();
  }
}
