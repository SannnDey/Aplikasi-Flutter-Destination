import 'package:flutter/material.dart';
import 'package:myapp/detail_screen.dart';
import 'package:myapp/favorites_screen.dart';
import 'package:myapp/login_screen.dart';
import 'package:myapp/model/tourism_place.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider package
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen({required this.userEmail, super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<bool> isFavorite =
      List<bool>.filled(tourismPlaceList.length, false);
  List<TourismPlace> displayedPlaces = tourismPlaceList;
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  final bool _isLoading = false;
  bool showAll = false;
  // Add VideoPlayerController
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    // Initialize VideoPlayerController with the local asset
    _videoController = VideoPlayerController.asset('images/balivideo.mp4');

    // Initialize the controller and store the Future for later use
    _initializeVideoPlayerFuture = _videoController.initialize().then((_) {
      setState(
          () {}); // Ensure the first frame is shown after the video is initialized
    });

    // Optionally, you can set looping or other configurations
    _videoController.setLooping(false);
  }

  void _onSearchChanged() {
    setState(() {
      displayedPlaces = tourismPlaceList.where((place) {
        return place.name
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            place.location
                .toLowerCase()
                .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? buildHomeContent()
          : buildFavoritesContent(widget.userEmail),
      drawer: buildDrawer(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange[800],
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
              });
            },
          ),
          ListTile(
            title: const Text('Favorites'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.orange[800],
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Widget buildHomeContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Bali Destination'),
          backgroundColor: Colors.orange,
          floating: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: const Icon(Icons.search, color: Colors.orange),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                ),
                onChanged: (value) {
                  _onSearchChanged();
                },
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Check if search is active
              if (_searchController.text.isEmpty) ...[
                // Show the Carousel Slider and Featured Video only when no search is active
                buildCarouselSlider(),
                const SizedBox(height: 10),

                _buildSectionDivider('Featured Video'),

                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            _videoController.play();
                            return AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                              'Discover Bali through this video showcasing the most beautiful spots!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _videoController.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _videoController.value.isPlaying
                                          ? _videoController.pause()
                                          : _videoController.play();
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.replay_10,
                                      color: Colors.orange),
                                  onPressed: () {
                                    final currentPosition =
                                        _videoController.value.position;
                                    _videoController.seekTo(
                                      currentPosition - Duration(seconds: 10),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.forward_10,
                                      color: Colors.orange),
                                  onPressed: () {
                                    final currentPosition =
                                        _videoController.value.position;
                                    _videoController.seekTo(
                                      currentPosition + Duration(seconds: 10),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    _videoController.value.volume == 0
                                        ? Icons.volume_off
                                        : Icons.volume_up,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _videoController.value.volume == 0
                                          ? _videoController.setVolume(1.0)
                                          : _videoController.setVolume(0.0);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                _buildSectionDivider('Explore the Best Attractions'),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Text(
                    'Bali is home to a wide variety of stunning attractions. From beautiful beaches to lush rice terraces, explore the best that Bali has to offer. Whether you are looking for adventure, relaxation, or cultural experiences, you will find it all here.',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.justify,
                  ),
                ),

                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'images/terasering.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bali Rice Terraces',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Explore the stunning rice terraces of Bali, a breathtaking sight that offers both beauty and tranquility.',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              // Show the Tourism GridView regardless of search status
              buildTourismGridView(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

// Function to create a section divider with a title
  Widget _buildSectionDivider(String title) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.orange,
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.orange,
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
      ],
    );
  }

  Widget buildCarouselSlider() {
    // Daftar gambar dan destinasi
    List<Map<String, String>> destinations = [
      {
        'image': 'images/bedugul.jpg',
        'name': 'Bedugul',
      },
      {
        'image': 'images/gwk.jpg',
        'name': 'Garuda Wisnu Kencana',
      },
      {
        'image': 'images/pura_besakih.jpg',
        'name': 'Pura Besakih',
      },
      {
        'image': 'images/monkey_forest.jpg',
        'name': 'Ubud Monkey Forest',
      },
    ];

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
          ),
          // Bangun setiap item dalam slider dari daftar destinasi
          items: destinations.map((item) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item['image']!), // Gambar destinasi
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  item['name']!, // Nama destinasi yang ditampilkan
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    backgroundColor:
                        Colors.black54, // Background untuk keterbacaan
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        // Indicator for current image (optional)
      ],
    );
  }

  Widget buildTourismGridView() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : displayedPlaces.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 100, color: Colors.grey[400]),
                    const SizedBox(height: 20),
                    Text(
                      'Oops.. Destination Not Found..',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width < 600 ? 2 : 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: showAll
                          ? displayedPlaces.length
                          : (displayedPlaces.length < 6
                              ? displayedPlaces.length
                              : 6),
                      itemBuilder: (context, index) {
                        final TourismPlace place = displayedPlaces[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  place: place,
                                  userEmail: widget.userEmail,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        ),
                                        child: Image.asset(
                                          place.imageAsset,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            place.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.orange[900],
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            place.location,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: IconButton(
                                    key: ValueKey<bool>(isFavorite[index]),
                                    icon: Icon(
                                      isFavorite[index]
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite[index]
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isFavorite[index] = !isFavorite[index];
                                      });
                                      final snackBar = SnackBar(
                                        content: Text(isFavorite[index]
                                            ? '${place.name} added to favorites!'
                                            : '${place.name} removed from favorites!'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    if (displayedPlaces.length > 6)
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: TextButton.icon(
                          key: ValueKey<bool>(showAll),
                          onPressed: () {
                            setState(() {
                              showAll = !showAll;
                            });
                          },
                          icon: Icon(
                            showAll ? Icons.arrow_upward : Icons.arrow_downward,
                            color: Colors.blue,
                          ),
                          label: Text(
                            showAll ? 'See Less' : 'See More',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                          ),
                        ),
                      ),
                  ],
                ),
              );
  }

  Widget buildFavoritesContent(String userEmail) {
    // Accept userEmail as a parameter
    final List<TourismPlace> favoritePlaces = tourismPlaceList
        .where((place) => isFavorite[tourismPlaceList.indexOf(place)])
        .toList();

    return FavoritesScreen(
      favoritePlaces: favoritePlaces,
      userEmail: userEmail, // Pass userEmail to FavoritesScreen
    );
  }
}
