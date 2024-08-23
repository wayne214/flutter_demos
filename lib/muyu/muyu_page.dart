import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/muyu/count_panel.dart';
import 'package:flutter_demos/muyu/models/audio_option.dart';
import 'package:flutter_demos/muyu/muyu_app_bar.dart';
import 'package:flutter_demos/muyu/options/select_audio.dart';
import 'package:uuid/uuid.dart';

import '../storage/sp_storage.dart';
import 'models/image_option.dart';
import 'models/merit_record.dart';
import 'muyu_image.dart';
import 'options/select_image.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {

  int _activeImageIndex = 0;
  int _activeAudioIndex = 0;

  int _counter = 0;
  MeritRecord? _cruRecord;

  final Uuid uuid = const Uuid();
  final Random _random = Random();

  final List<AudioOption> audioOptions = const [
    AudioOption('音效1',  'muyu_1.mp3'),
    AudioOption('音效2',  'muyu_2.mp3'),
    AudioOption('音效3',  'muyu_3.mp3'),
  ];

  final List<ImageOption> imageOptions = const [
    ImageOption('基础版', 'assets/images/muyu.png', 1, 3),
    ImageOption('尊享版', 'assets/images/muyu2.png', 3, 6),
  ];

  @override
  void initState() {
    super.initState();
    _initConfig();
    _initAudioPool();
  }

  void _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readMuYUConfig();
    _counter = config['count'] ?? 0;
    _activeImageIndex = config['activeImageIndex'] ?? 0;
    _activeAudioIndex = config['activeImageIndex']?? 0;
    setState(() {

    });
  }

  AudioPool? pool;
  void _initAudioPool() async {
    pool = await FlameAudio.createPool(audioOptions[1].src, maxPlayers: 1);
  }

  String get activeImage => imageOptions[_activeImageIndex].src;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MuyuAppBar(onTapHistory: _toHistory),
        body: Column(
          children: [
            Expanded(
                child: CountPanel(
              count: _counter,
              onTapSwitchAudio: _onTapSwitchAudio,
              onTapSwitchImage: _onTapSwitchImage,
            )),
            Expanded(child: Stack(alignment: Alignment.center, children: [
              MuyuAssetsImage(image: activeImage, onTap: _onKnock),
            ]))
          ],
        ));
  }

  int get knockValue {
    int min = imageOptions[_activeImageIndex].min;
    int max = imageOptions[_activeImageIndex].max;
    return min + _random.nextInt(max + 1 - min);
  }

  void _onKnock() {
    pool?.start();
    setState(() {
      String id = uuid.v4();
      _cruRecord = MeritRecord(
        id,
        DateTime.now().millisecondsSinceEpoch,
        knockValue,
        activeImage,
        audioOptions[_activeAudioIndex].name,
      );
      _counter += _cruRecord!.value;
      saveConfig();
    });

  }

  void saveConfig() {
    SpStorage.instance.saveMuYUConfig(
      counter: _counter,
      activeImageIndex: _activeImageIndex,
      activeAudioIndex: _activeAudioIndex,
    );
  }

  void _toHistory() {
    Navigator.of(context).pushNamed('/history');
  }

  void _onTapSwitchAudio() {
   showCupertinoModalPopup(context: context, builder: (BuildContext context){
     return AudioOptionPanel(audioOptions: audioOptions, activeIndex: _activeAudioIndex, onSelect: _onSelectAudio);
   });
  }

  void _onTapSwitchImage() {
    showCupertinoModalPopup(context: context, builder: (BuildContext context){
      return ImageOptionPanel(imageOptions: imageOptions, activeIndex: _activeImageIndex, onSelect: _onSelectImage);
    });
  }

  void _onSelectImage(int value) {
    Navigator.of(context).pop();

    if(value == _activeImageIndex) return;

    setState(() {
      _activeImageIndex = value;
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
