import 'package:flutter/material.dart';

void main() => runApp(const BeatFreeApp());

const bg = Color(0xFF090B12);
const panel = Color(0xFF141824);
const accent = Color(0xFFB8FF5C);
const muted = Color(0xFF9299AA);

class BeatFreeApp extends StatelessWidget {
  const BeatFreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeatFree',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(primary: accent, surface: panel),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Track {
  const Track(this.title, this.artist, this.icon, this.color);
  final String title;
  final String artist;
  final IconData icon;
  final Color color;
}

const tracks = <Track>[
  Track('Midnight Drive', 'Neon Nights', Icons.nightlight_round, Color(0xFF725BFF)),
  Track('Afterglow', 'Kairo', Icons.wb_twilight_rounded, Color(0xFFFF7A59)),
  Track('No Signal', 'Static Youth', Icons.graphic_eq_rounded, Color(0xFF29C7AC)),
  Track('Blue Hour', 'Luna Park', Icons.water_drop_rounded, Color(0xFF459CFF)),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  String query = '';
  int selectedTab = 0;
  int playingIndex = 0;
  bool isPlaying = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = tracks.where((t) =>
      t.title.toLowerCase().contains(query.toLowerCase()) ||
      t.artist.toLowerCase().contains(query.toLowerCase())).toList();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 22, 12),
                  child: Row(
                    children: [
                      Container(
                        width: 42, height: 42,
                        decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(14)),
                        child: const Icon(Icons.equalizer_rounded, color: bg, size: 28),
                      ),
                      const SizedBox(width: 12),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('BeatFree', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.7)),
                        Text('YOUR SOUND. YOUR SPACE.', style: TextStyle(fontSize: 9, color: muted, letterSpacing: 1.5)),
                      ]),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Profile',
                        onPressed: () => _message('Profile settings coming soon'),
                        icon: const Icon(Icons.account_circle_outlined, size: 28),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(22, 8, 22, 20),
                    children: [
                      const Text('YOUR MUSIC,', style: TextStyle(fontSize: 30, height: 1.1, fontWeight: FontWeight.w800, letterSpacing: -1.2)),
                      const Text('WITHOUT THE NOISE.', style: TextStyle(fontSize: 30, height: 1.1, fontWeight: FontWeight.w800, letterSpacing: -1.2, color: accent)),
                      const SizedBox(height: 10),
                      const Text('A calmer place for the songs you love.', style: TextStyle(color: muted, fontSize: 14)),
                      const SizedBox(height: 24),
                      TextField(
                        controller: searchController,
                        onChanged: (v) => setState(() => query = v),
                        decoration: InputDecoration(
                          hintText: 'Search tracks or artists',
                          hintStyle: const TextStyle(color: muted),
                          prefixIcon: const Icon(Icons.search_rounded, color: muted),
                          filled: true,
                          fillColor: panel,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(vertical: 17),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          gradient: const LinearGradient(colors: [Color(0xFF252C3B), Color(0xFF171C28)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(color: accent.withValues(alpha: 0.13), borderRadius: BorderRadius.circular(30)),
                                child: const Text('FEATURED MIX', style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                              ),
                              const SizedBox(height: 14),
                              const Text('Late Night\nFrequency', style: TextStyle(fontSize: 25, height: 1.05, fontWeight: FontWeight.w800, letterSpacing: -0.8)),
                              const SizedBox(height: 8),
                              const Text('Focus • Chill • Repeat', style: TextStyle(color: muted, fontSize: 12)),
                              const SizedBox(height: 16),
                              FilledButton.icon(
                                style: FilledButton.styleFrom(backgroundColor: accent, foregroundColor: bg),
                                onPressed: () => setState(() { playingIndex = 0; isPlaying = !isPlaying; }),
                                icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
                                label: Text(isPlaying ? 'Pause demo' : 'Play demo'),
                              ),
                            ])),
                            const SizedBox(width: 12),
                            Container(
                              width: 112, height: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(colors: [Color(0xFFB8FF5C), Color(0xFF36BFA0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                              ),
                              child: const Icon(Icons.headphones_rounded, size: 68, color: Color(0xFF10201A)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(children: [
                        const Expanded(child: Text('Made for your mood', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.4))),
                        Text('${filtered.length} tracks', style: const TextStyle(color: muted, fontSize: 12)),
                      ]),
                      const SizedBox(height: 12),
                      if (filtered.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('No matches yet. Try another search.', textAlign: TextAlign.center, style: TextStyle(color: muted)),
                        )
                      else
                        ...filtered.map((track) {
                          final originalIndex = tracks.indexOf(track);
                          final active = originalIndex == playingIndex && isPlaying;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 9),
                            child: Material(
                              color: panel,
                              borderRadius: BorderRadius.circular(18),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                leading: Container(
                                  width: 48, height: 48,
                                  decoration: BoxDecoration(color: track.color.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(14)),
                                  child: Icon(track.icon, color: track.color, size: 26),
                                ),
                                title: Text(track.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                                subtitle: Text(track.artist, style: const TextStyle(color: muted, fontSize: 12)),
                                trailing: IconButton(
                                  onPressed: () => setState(() {
                                    if (playingIndex == originalIndex) {
                                      isPlaying = !isPlaying;
                                    } else {
                                      playingIndex = originalIndex;
                                      isPlaying = true;
                                    }
                                  }),
                                  icon: Icon(active ? Icons.pause_circle_filled_rounded : Icons.play_circle_outline_rounded, size: 30, color: active ? accent : Colors.white70),
                                ),
                              ),
                            ),
                          );
                        }),
                      const SizedBox(height: 8),
                      const Text('STARTER PREVIEW • DEMO TRACKS ONLY', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF666D7C), fontSize: 9, letterSpacing: 1.2)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
                  decoration: BoxDecoration(color: const Color(0xFF0D1018), border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.06)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navItem(Icons.home_rounded, 'Home', 0),
                      _navItem(Icons.explore_outlined, 'Explore', 1),
                      _navItem(Icons.favorite_border_rounded, 'Liked', 2),
                      _navItem(Icons.library_music_outlined, 'Library', 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final active = selectedTab == index;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        setState(() => selectedTab = index);
        if (index != 0) _message('$label section is coming soon');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: active ? accent : muted, size: 22),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(color: active ? accent : muted, fontSize: 10, fontWeight: active ? FontWeight.w700 : FontWeight.w500)),
        ]),
      ),
    );
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: panel,
      behavior: SnackBarBehavior.floating,
    ));
  }
}
