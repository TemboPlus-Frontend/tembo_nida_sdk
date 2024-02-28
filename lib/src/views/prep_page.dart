import 'package:tembo_nida_sdk/src/views/info_page.dart';
import 'package:tembo_nida_sdk/src/views/root_app.dart';

import '../../source.dart';

class PrepPage extends TemboStatefulPage {
  const PrepPage({super.key});

  @override
  String get name => "prep-page";

  @override
  State<PrepPage> createState() => _PrepPageState();
}

class _PrepPageState extends State<PrepPage> {
  @override
  Widget build(BuildContext context) {
    final steps = context.l.ninSteps.steps.split(":");

    return Scaffold(
      appBar: TemboAppBar(),
      body: ListView(
        padding: kHorPadding,
        children: [
          Padding(
            padding: bottom(20),
            child: Image.asset("packages/tembo_nida_sdk/assets/face-id.png",
                height: 180),
          ),
          TemboText.center(
            context.l.ninSteps.desc,
            style: context.textTheme.bodyLarge,
          ),
          vSpace(30),
          Padding(
            padding: left(25),
            child: TemboText.bold(
              context.l.ninSteps.me,
              style: context.textTheme.bodyLarge.withPrimaryColor,
            ),
          ),
          ListView.separated(
            itemCount: steps.length,
            shrinkWrap: true,
            padding: left(25),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => vSpace(0),
            itemBuilder: (context, i) {
              return ListTile(
                leading: TemboContainer(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: TemboBoxDecoration(
                    color: context.colorScheme.surfaceTint,
                    radius: kBorderRadius2,
                  ),
                  child: TemboText(
                    "${i + 1}",
                    style: context.textTheme.bodyMedium.bold.withOnPrimaryColor,
                  ),
                ),
                title: TemboText(steps[i]),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: TemboBottomButton(
        callback: onPressed,
        text: context.l.next,
      ),
    );
  }

  onPressed() {
    temboNIDASDKRootNavKey.push3(const BasicInfoPage());
  }
}
