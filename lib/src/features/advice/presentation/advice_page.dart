import 'package:flutter/material.dart';
import 'package:ibdex/src/shared/models/advice.dart';
import 'advice_detail_page.dart';

class AdvicesPage extends StatelessWidget {
  const AdvicesPage({super.key});

  // mock des conseils
  static final List<Advice> _mockAdvices = [
    Advice(
      id: '1',
      title: "Ne négligez pas les examens biologiques!",
      category: 'Maladie',
      content: "Il est important de faire ses prises de sang et ses coprocultures...",
      imageUrl: 'https://picsum.photos/400/200?random=11',
      publishedAt: DateTime.now(),
      myExperience: "De mon point de vue, j'ai eu beaucoup de mal à faire mes examens par procrastination ou par manque de temps..."
    ),
    Advice(
      id: '2',
      title: "Concernant la demande RQTH",
      category: 'Maladie',
      content: "Dès que vous avez reçu votre diagnostic, il est conseillé que vous fassiez votre demande RQTH...",
      imageUrl: 'https://picsum.photos/400/200?random=12',
      publishedAt: DateTime.now(),
      myExperience: "De mon côté, j'ai eu beaucoup de mal à mettre en place une RQTH dû à l'attente de validation..."
    ),
    Advice(
      id: '3',
      title: "Conseils simple sur l'alimentation",
      category: 'Nutrition',
      content: "Si vous ressentez des poussées à force de manger la même chose ou un même aliment...",
      imageUrl: 'https://picsum.photos/400/200?random=13',
      publishedAt: DateTime.now(),
      myExperience: "De mon côté, j'ai du limiter les sodas et le gluten car j'ai remarqué que mes poussées se déclenchaient..."
    ),
  ];

  Widget _buildAdviceItem(BuildContext context, Advice advice) {
    return InkWell(
      onTap: () {
        // TODO: Implémenter la navigation vers le détail du conseil
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => AdviceDetailPage(advice: advice))
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // badge de catégorie
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: advice.category == 'Nutrition' ? Colors.green.shade100 : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      advice.category,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: advice.category == 'Nutrition' ? Colors.green.shade800 : Colors.orange.shade800
                      ),
                    ),
                  ),
                  const Icon(Icons.lightbulb_outline, color: Colors.amber),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                advice.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                advice.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const Divider(height: 20),
              // section 'Mon expérience'
              Row(
                children: [
                  const Icon(Icons.comment, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Mon vécu : ${advice.myExperience}",
                      style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _mockAdvices.length,
        itemBuilder: (context, index){
          final advice = _mockAdvices[index];
          return _buildAdviceItem(context, advice);
        },
      ),
    );
  }
}
