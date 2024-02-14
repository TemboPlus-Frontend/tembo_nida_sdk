import 'package:tembo_nida_sdk/src/logic/models/user.dart';

import '../../source.dart';
import 'root_app.dart';

class SuccessPage extends TemboPage {
  final NIDAUser user;
  const SuccessPage(this.user, {super.key});

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
            Image.asset(
              "packages/tembo_nida_sdk/assets/success.png",
              height: 128,
            ),
            vSpace(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Hi ",
                    style: context.textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: "${user.firstName} ${user.lastName}",
                    style: context.textTheme.bodyMedium.bold,
                  ),
                  TextSpan(
                    text: ", We have successfully verified your NIN Number",
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            vSpace(),
          ],
        ),
      ),
      bottomNavigationBar: TemboBottomButton(
        callback: () => popBackToPrevApp(user),
        text: "Okay",
      ),
    );
  }
}
