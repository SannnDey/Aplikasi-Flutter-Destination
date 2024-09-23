import 'package:flutter/material.dart';
import 'package:myapp/detail_screen.dart';
import 'package:myapp/favorites_screen.dart';
import 'package:myapp/login_screen.dart';
import 'package:myapp/model/tourism_place.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<bool> isFavorite = List<bool>.filled(tourismPlaceList.length, false);
  List<TourismPlace> displayedPlaces = tourismPlaceList;
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_searchController.text.isEmpty) {
        setState(() {
          displayedPlaces = tourismPlaceList;
        });
      } else {
        setState(() {
          _isLoading = true;
        });
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            displayedPlaces = tourismPlaceList
                .where((place) =>
                    place.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                    place.location.toLowerCase().contains(_searchController.text.toLowerCase()))
                .toList();
            _isLoading = false; 
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bali Tourism',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange[800],
      ),
      body: _currentIndex == 0 ? buildHomeContent() : buildFavoritesContent(),
      drawer: Drawer(
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
              leading: const Icon(Icons.explore),
              title: const Text('Explore'),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }

  void _logout() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          TextButton(
            child: const Text('Logout'),
            onPressed: () {
              Navigator.of(context).pop();
              _showLoadingDialog();
            },
          ),
        ],
      );
    },
  );
}

void _showLoadingDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Please wait...'),
          ],
        ),
      );
    },
  );

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop(); 
    _showLogoutMessage(); 
  });
}

void _showLogoutMessage() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.orange[50],
        title: Row(
          children: [
            const Icon(
              Icons.exit_to_app,
              color: Colors.orange,
              size: 28,
            ),
            const SizedBox(width: 10),
            const Text(
              'Goodbye!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'See You Next Time!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]!),
            ),
          ],
        ),
      );
    },
  );

  Future.delayed(const Duration(seconds: 3), () {
    Navigator.of(context).pop(); 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  });
}



  Widget buildHomeContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search Destination...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 0.8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Expanded(
                child: displayedPlaces.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 100,
                              color: Colors.grey[400],
                            ),
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
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: displayedPlaces.length,
                          itemBuilder: (context, index) {
                            final TourismPlace place = displayedPlaces[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(place: place),
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
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          isFavorite[index] ? Icons.favorite : Icons.favorite_border,
                                          color: isFavorite[index] ? Colors.red : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isFavorite[index] = !isFavorite[index];
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ),
      ],
    );
  }

  Widget buildFavoritesContent() {
    final List<TourismPlace> favoritePlaces = tourismPlaceList
        .where((place) => isFavorite[tourismPlaceList.indexOf(place)]).toList();

    return FavoritesScreen(favoritePlaces: favoritePlaces);
  }
}
