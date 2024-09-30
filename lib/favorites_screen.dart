import 'package:flutter/material.dart';
import 'package:myapp/model/tourism_place.dart';
import 'package:myapp/detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<TourismPlace> favoritePlaces;
  final String userEmail;

  const FavoritesScreen({required this.favoritePlaces, required this.userEmail, super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<TourismPlace> _favoritePlaces;

  @override
  void initState() {
    super.initState();
    _favoritePlaces = List.from(widget.favoritePlaces);
  }

  void _removeFromFavorites(TourismPlace place) {
    setState(() {
      _favoritePlaces.remove(place);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.orange[800],
        elevation: 0,
      ),
      body: Container(
        child: _favoritePlaces.isEmpty
            ? Center(
                child: Text(
                  'No Favorite Destination Added',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _favoritePlaces.length,
                itemBuilder: (context, index) {
                  final place = _favoritePlaces[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          place.imageAsset,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        place.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(place.location),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _removeFromFavorites(place);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              place: place,
                              userEmail: widget.userEmail, // Pass the userEmail
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
