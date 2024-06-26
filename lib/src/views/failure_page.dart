import 'package:tembo_nida_sdk/src/views/root_app.dart';

import '../../source.dart';

class FailurePage extends TemboPage {
  const FailurePage({super.key});

  @override
  String get name => "failure";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(label: ""),
      body: Container(
        constraints: kMaxConstraints,
        padding: kPagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("packages/tembo_nida_sdk/assets/ver_failed.png",
                height: 150),
            vSpace(),
            TemboText.center(
              context.l.ninFailurePage.msg,
              style: context.textTheme.bodyLarge,
            ),
            vSpace(),
            TemboTextButton(
              onPressed: () {
                temboNIDASDKRootNavKey.currentState!
                    .popUntil((route) => route.settings.name == "nin");
              },
              style: TemboButtonStyle.outline(
                foregroundColor: context.colorScheme.primary,
                textStyle: context.textTheme.bodyMedium.bold,
                borderRadius: kBorderRadius3,
              ),
              child: TemboText(context.l.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}
