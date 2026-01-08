import 'package:flutter/material.dart';

import '../../../../config/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static String routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < 2) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boas-vindas')),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (i) => setState(() => _page = i),
              children: const [
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text('Bem-vindo ao EcommerceCenter!')),
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text('Gerencie produtos, vendas e assinaturas com facilidade.')),
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text('Pronto para começar?')),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: smallSpacing, vertical: mediumSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    if (_page == 0) return Navigator.pop(context);
                    _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                  },
                  child: Text(_page == 0 ? 'Voltar' : 'Anterior'),
                ),
                ElevatedButton(
                  onPressed: _next,
                  child: Text(_page == 2 ? 'Concluir' : 'Próximo'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
