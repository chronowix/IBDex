import 'package:ibdex/src/shared/models/advice.dart';
import 'package:ibdex/src/shared/models/article.dart';

class MockData {
  static final List<Article> articles = [
    Article(
      id: '1',
      title: "Nouvelles sur Crohn",
      content: "Découvrez les dernières avancées sur les traitements personnalisés à Rennes...",
      imageUrl: "https://picsum.photos/400/200?random=11",
      category: "Maladie",
      publishedAt: DateTime.now(),
    ),
    Article(
      id: '2',
      title: "Nouvelles sur la nouvelle molécule",
      content: "Un nouveau type de dépistage a été découvert pour améliorer le confort des patients...",
      imageUrl: "https://picsum.photos/400/200?random=12",
      category: "Soins",
      publishedAt: DateTime.now(),
    ),
    Article(
      id: '3',
      title: "Les traitements à Rennes",
      content: "Où se soigner en Bretagne et quels sont les centres de référence ?",
      imageUrl: "https://picsum.photos/400/200?random=13",
      category: "Soins",
      publishedAt: DateTime.now(),
    ),
  ];

  static final List<Advice> advices = [
    Advice(
      id: "1",
      title: "Ne négligez pas les examens !",
      content: "Il est important de faire ses prises de sang et ses coprocultures régulièrement.",
      imageUrl: "https://picsum.photos/400/200?random=21",
      category: "Maladie",
      publishedAt: DateTime.now(),
      myExperience: "De mon point de vue, j'ai eu beaucoup de mal à faire mes examens par procrastination...",
    ),
    Advice(
      id: "2",
      title: "Concernant la demande RQTH",
      content: "Dès que vous avez reçu votre diagnostic, il est conseillé de faire votre demande.",
      imageUrl: "https://picsum.photos/400/200?random=22",
      category: "Démarches",
      publishedAt: DateTime.now(),
      myExperience: "De mon côté, j'ai eu beaucoup de mal à mettre en place une RQTH dû à l'attente...",
    ),
    Advice(
      id: "3",
      title: "Conseils sur l'alimentation",
      content: "Si vous ressentez des poussées à force de manger la même chose...",
      imageUrl: "https://picsum.photos/400/200?random=23",
      category: "Nutrition",
      publishedAt: DateTime.now(),
      myExperience: "De mon côté, j'ai dû limiter les sodas et le gluten...",
    ),
  ];
}
