import 'package:flutter/material.dart';
import 'package:ibdex/src/features/wiki/presentation/wiki_detail_page.dart';
import '../data/wiki_service.dart';
import '../models/wiki_article.dart';

class WikiCategoryPage extends StatefulWidget{
  final String categoryTitle;
  final List<String> wikiTitles;

  const WikiCategoryPage({
    super.key,
    required this.categoryTitle,
    required this.wikiTitles,
  });

  @override
  State<WikiCategoryPage> createState() => _WikiCategoryPageState();
}

class _WikiCategoryPageState extends State<WikiCategoryPage>{
  final WikiService _wikiService = WikiService();
  final List<WikiArticle> _articles = [];
  bool _isLoading = true;
  String? _errMessage;

  @override
  void initState(){
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async{
    try{
      for (String title in widget.wikiTitles){
        final json = await _wikiService.fetchSummary(title);
        _articles.add(WikiArticle.fromJson(json));
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e){
      setState(() {
        _isLoading = false;
        _errMessage = "Erreur de connexion aux données de Wikipédia";
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryTitle)),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    if (_isLoading){
      return const Center(child: CircularProgressIndicator());
    }

    if(_errMessage != null){
      return Center(child: Text(_errMessage!));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _articles.length,
      itemBuilder: (context, index){
        final article = _articles[index];
        return _buildArticleCard(article);
      },
    );
  }

  Widget _buildArticleCard(WikiArticle article) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: article.thumbnailUrl != null
            ? SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: Colors.grey.shade100, // Fond blanc cassé
                    child: Image.network(
                      article.thumbnailUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              )
            : const Icon(Icons.article, size: 40),
        title: Text(article.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          article.desc ?? "Consulter l'article Wikipédia",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WikiDetailPage(
                  article: article
              ),
            ),
          );
        },
      ),
    );
  }
}