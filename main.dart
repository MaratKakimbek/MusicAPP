import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musical Wave',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Musical Wave'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'All Music',
            ),
            NavigationDestination(
              icon: Icon(Icons.library_music),
              label: 'New Feature',
            ),
          ],
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          }),
      body: [
        ListView.builder(itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            final int i = index;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MusicPage(index: i,),)
            );
          },
          child: ListTile(
            leading: const Icon(Icons.music_note),
            title: Text('Music №$index'),
          )
        ), itemCount: 13,),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(child: Text('New Feature')),
            ],
          ),
        ),
      ][currentPageIndex],
    );
  }
}

class MusicPage extends StatefulWidget {
  final int index;
  const MusicPage({super.key, required this.index});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  List<String> musicList = [
    'https://now.morsmusic.org/load/922740196/Sora_Amamiya_-_Skyreach_(musmore.com).mp3',
    'https://now.morsmusic.org/load/1228351884/Rika_Mayama_-_Liar_Mask_(musmore.com).mp3',
    'https://mezzoforte.ru/s/artist/413459-skillet_falling_inside_the_black.mp3',
    'https://mezzoforte.ru/s/artist/442614-skillet_comatose_original.mp3',
    'https://minty.club/artist/thousand-foot-krutch/courtesy-call/thousand-foot-krutch-courtesy-call.mp3',
    'https://now.morsmusic.org/load/1090742654/YUI_-_Again_(musmore.com).mp3',
    'https://mezzoforte.ru/s/artist/419990-skillet_hero.mp3',
    'https://deliciouspeaches.com/get/music/20190428/Circus-P_feat_GUMI_-_Copycat_VOCALOID_63807200.mp3',
    'https://now.morsmusic.org/load/1376913392/Skillet_-_Whispers_in_the_Dark_(musmore.com).mp3',
    'https://now.morsmusic.org/load/918550313/Stereopony_-_Tsukiakari_No_Michishirube_(musmore.com).mp3',
    'https://now.morsmusic.org/load/738645079/KANA-BOON_-_Silhouette_(musmore.com).mp3',
    'https://now.morsmusic.org/load/2047687557/Flow_-_Sign_(musmore.com).mp3',
    'https://vgmsite.com/soundtracks/made-in-abyss-ost/xzaovufocc/1-23%20Hanezeve%20Caradhina%20%28ft.Takeshi%20Saito%29.mp3',
  ];
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  void previousMusicPage() {
    audioPlayer.pause();
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MusicPage(index: widget.index - 1,),)
    );
  }

  void nextMusicPage() {
    audioPlayer.pause();
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MusicPage(index: widget.index + 1,),)
    );
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    String url = musicList[widget.index];
    audioPlayer.setSourceUrl(url);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Musical Wave'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://img.freepik.com/free-vector/musical-notes-frame-with-text-space_1017-32857.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'Musical Wave',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'The Song ${widget.index}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);

                  await audioPlayer.resume();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$position'),
                    Text('${duration - position}'),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 35,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  iconSize: 50,
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      await audioPlayer.resume();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_circle_left_outlined),

                      iconSize: 40,
                      onPressed: widget.index != 0 ? () => previousMusicPage() : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_circle_right_outlined),
                      iconSize: 40,
                      onPressed: widget.index != musicList.length - 1 ? () => nextMusicPage() : null,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchDT = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Settings'),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SwitchListTile(
                title: Text('$_switchDT'),
                value: _switchDT,
                onChanged: (bool value) {
                  setState(() {
                    _switchDT = value;
                  });
                },
              ),
            ),
          ],
        ));
  }
}
