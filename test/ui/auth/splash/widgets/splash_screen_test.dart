import 'package:flutter_test/flutter_test.dart';
import 'package:project_skeleton/ui/auth/splash/widgets/splash_screen.dart';

import '../../../../../testing/my_app.dart';

void main() {
  testWidgets('should load screen', (tester) async {
    await testApp(tester, SplashScreen());

    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
