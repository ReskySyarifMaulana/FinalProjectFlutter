import 'package:flutter/material.dart';
import 'package:the_lazy_media/game_news_detail.dart';
import 'package:the_lazy_media/gamenews.dart';
import 'package:the_lazy_media/list.dart';
import 'package:the_lazy_media/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'THE LAZY NEWS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
            .copyWith(background: Colors.white),
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GameNews> gameNewsList = [];
  int currentPage = 1;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchGameNews();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _searchGameNews(String query) async {
    final searchResults = await searchGameNews(query);
    setState(() {
      gameNewsList = searchResults;
    });
  }

  Future<void> _fetchGameNews() async {
    try {
      final updatedGameNewsList = await fetchGameNews(currentPage);
      setState(() {
        gameNewsList.addAll(updatedGameNewsList);
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching game news: $e');
    }
  }

  Future<void> _refreshGameNews() async {
    currentPage = 1;
    final updatedGameNewsList = await fetchGameNews(currentPage);
    setState(() {
      gameNewsList = updatedGameNewsList;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreGameNews();
    }
  }

  Future<void> _loadMoreGameNews() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final nextPage = currentPage + 1;
      final updatedGameNewsList = await fetchGameNews(nextPage);
      setState(() {
        gameNewsList.addAll(updatedGameNewsList);
        currentPage = nextPage;
        isLoading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error loading more game news: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _endSearch() {
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _startSearch,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshGameNews,
        child: Column(
          children: [
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for game news...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _endSearch,
                    ),
                  ),
                  onSubmitted: _searchGameNews,
                ),
              ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: gameNewsList.length + 1,
                itemBuilder: (context, index) {
                  if (index == gameNewsList.length) {
                    return _buildLoadingIndicator();
                  }

                  final gameNews = gameNewsList[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 194, 110, 0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(gameNews.title),
                      leading: Image.network(gameNews.thumb),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GameNewsDetail(gameNews: gameNews),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
