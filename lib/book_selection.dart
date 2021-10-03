import 'package:byam/models/book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookSelectionScreen extends StatefulWidget {
  BookSelectionScreen({Key? key}) : super(key: key);

  @override
  _BookSelectionScreenState createState() => _BookSelectionScreenState();
}

class _BookSelectionScreenState extends State<BookSelectionScreen> {
  Map<String, Book> _recommanded = {};
  final List<Book> _rated = [];

  getRecommended() async {
    try {
      if (_rated.isEmpty) {
        var response = await Dio().get("http://localhost:8000/popularity");
        if (response.statusCode != 200) {
          return null;
        }
        for (var book in response.data as List) {
          final Book b = Book.fromJson(book);
          if (!_rated.contains(b)) _recommanded[book["book_title"]] = b;
        }
      }
      setState(() {
        _recommanded = _recommanded;
      });
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getRecommended();
  }

  @override
  Widget build(BuildContext context) {
    var listBooks = _recommanded.entries.toList();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                centerTitle: true,
                title: const Text('Inscription'),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'assets/books_lot.png',
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.0, 0.5),
                          end: Alignment.center,
                          colors: <Color>[
                            Color(0x60000000),
                            Color(0x00000000),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          if (_rated.isNotEmpty)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Vos livres notés',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: .7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildImage(_rated[index]);
              },
              childCount: _rated.length,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Quels livres avez-vous aimé ?',
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: .7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildImage(listBooks[index].value);
              },
              childCount: listBooks.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Book book) {
    return GestureDetector(
      onTap: () {
        _openBook(context, book);
      },
      child: Hero(
        tag: book.title,
        child: Image.network(book.cover, scale: .5),
      ),
    );
  }

  _openBook(BuildContext context, Book book) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => BookItem(book)));
    if (result != null) {
      book.rating = result;
      setState(() {
        _rated.add(book);
        _recommanded.remove(book.title);
      });
      getRecommended();
    }
  }
}

class BookItem extends StatelessWidget {
  final Book book;
  const BookItem(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: book.title,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: Image.network(book.cover, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: const [
                Text("A quel point l'avez vous aimé ?",
                    style: TextStyle(fontSize: 20)),
                Icon(Icons.favorite, color: Colors.pink),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                List.generate(5, (int index) => _buildStar(context, index + 1)),
          ),
        ],
      ),
    );
  }

  _buildStar(BuildContext context, int rating) {
    return IconButton(
        onPressed: () => {Navigator.pop(context, rating)},
        icon: Icon(book.rating != null && book.rating! >= rating
            ? Icons.star
            : Icons.star_outline));
  }
}
