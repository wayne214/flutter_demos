import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/muyu/count_panel.dart';
import 'package:flutter_demos/muyu/models/audio_option.dart';
import 'package:flutter_demos/muyu/muyu_app_bar.dart';
import 'package:flutter_demos/muyu/options/select_audio.dart';

import 'muyu_image.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {

  int _activeImageIndex = 0;
  int _activeAudioIndex = 0;

  final List<AudioOption> audioOptions = const [
    AudioOption('正常',  'muyu_1.mp3'),
    AudioOption('静音',  'muyu_2.mp3'),
    AudioOption('音量',  'muyu_3.mp3'),
  ];

  @override
  void initState() {
    super.initState();
    _initAudioPool();
  }

  AudioPool? pool;
  void _initAudioPool() async {
    pool = await FlameAudio.createPool(audioOptions[1].src, maxPlayers: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MuyuAppBar(onTapHistory: _toHistory),
        body: Column(
          children: [
            Expanded(
                child: CountPanel(
              count: 1,
              onTapSwitchAudio: _onTapSwitchAudio,
              onTapSwitchImage: () {},
            )),
            Expanded(child: Stack(alignment: Alignment.center, children: [
              MuyuAssetsImage(image: 'assets/images/muyu.png', onTap: () {
                pool?.start();
              }),
            ]))
          ],
        ));
  }

  void _toHistory() {
    Navigator.of(context).pushNamed('/history');
  }

  void _onTapSwitchAudio() {
   showCupertinoModalPopup(context: context, builder: (BuildContext context){
     return AudioOptionPanel(audioOptions: audioOptions, activeIndex: _activeAudioIndex, onSelect: _onSelectAudio);
   });
  }

  void _onSelectAudio(int value) async {
    Navigator.of(context).pop();
    if (value != _activeAudioIndex) {
      _activeAudioIndex = value;
      pool = await FlameAudio.createPool(audioOptions[value].src, maxPlayers: 1);
    }
  }
}
