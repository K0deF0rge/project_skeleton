import 'package:flutter_test/flutter_test.dart';
import 'package:project_skeleton/ui/auth/onboarding/widgets/onboarding_screen.dart';

import '../../../../testing/my_app.dart';

void main() {
  testWidgets('OnboardingScreen loads and shows pages and buttons', (
    tester,
  ) async {
    await testApp(tester, const OnboardingScreen());

    expect(find.text('Boas-vindas'), findsOneWidget);

    expect(find.textContaining('Bem-vindo'), findsOneWidget);

    expect(find.text('Próximo'), findsOneWidget);
    expect(find.text('Voltar'), findsOneWidget);
  });
}
