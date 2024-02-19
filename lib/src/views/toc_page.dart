import 'package:tembo_nida_sdk/src/views/root_app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../source.dart';
import '../view_models/navigator_manager.dart';
import 'prep_page.dart';

/// Prompts the user to agree to TemboPlus's Terms & Conditions
class TOCPage extends TemboStatefulPage {
  const TOCPage({super.key});

  @override
  String get name => "toc";

  @override
  State<TOCPage> createState() => _TOCPageState();
}

class _TOCPageState extends State<TOCPage> {
  bool agreedToTOC = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(
        label: context.loc.toc.title,
        onBackPress: prevAppNavManager.value.pop,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: kHorPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        "packages/tembo_core/assets/logo_round.png",
                        height: 150,
                      ),
                      const SizedBox(height: 20),
                      const TemboText("TEMBO PLUS INC."),
                      const SizedBox(height: 10),
                      TemboText(
                        context.loc.toc.desc,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TemboTextButton(
                        onPressed: showTOC,
                        style: const TemboButtonStyle.outline(),
                        child: TemboText(context.loc.toc.readTerms),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: kHorPadding.right),
                child: Row(
                  children: [
                    Checkbox.adaptive(
                      value: agreedToTOC,
                      onChanged: updateAgreeStatus,
                      checkColor: lightTheme.colorScheme.onPrimary,
                      fillColor: agreedToTOC
                          ? MaterialStatePropertyAll(lightTheme.colorScheme.primary)
                          : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TemboText(
                        context.loc.toc.readAlready,
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
      bottomNavigationBar:
          agreedToTOC ? TemboBottomButton(callback: next) : const _Button(),
    );
  }

  void updateAgreeStatus(bool? value) {
    if (value == null) return;
    setState(() => agreedToTOC = value);
  }

  void showTOC() async {
    try {
      launchUrl(Uri.parse("https://www.temboplus.com/app/privacy.html"));
    } catch (e) {
      showSnackbar("$e");
    }
  }

  void next() {
    sdkRootNavKey.push2(const PrepPage());
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TemboTextButton(
        onPressed: () {},
        child: TemboText(context.loc.next),
      ),
    );
  }
}
