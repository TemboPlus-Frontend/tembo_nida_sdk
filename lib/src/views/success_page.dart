import '../../source.dart';
import 'root_app.dart';

class SuccessPage extends TemboPage {
  const SuccessPage({super.key});

  @override
  String get name => "success";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(label: ""),
      body: Container(
        constraints: kMaxConstraints,
        padding: kHorPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemboText.center(
              "We have successfully verified your NIN Number",
              style: context.textTheme.bodyLarge.withFW500,
            ),
            vSpace(),
            const TemboText.center(
              "Your Account Number should be available shortly.",
            ),
          ],
        ),
      ),
      bottomNavigationBar: const TemboBottomButton(
        callback: popBackToPrevApp,
        text: "Okay",
      ),
    );
  }
}
