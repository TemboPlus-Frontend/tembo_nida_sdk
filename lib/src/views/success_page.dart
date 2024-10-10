import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/models/user.dart';

import '../../source.dart';
import 'root_app.dart';

class SuccessPage extends ConsumerStatefulWidget {
  final NIDAUser user;
  const SuccessPage(this.user, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuccessPageState();
}

class _SuccessPageState extends ConsumerState<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return AppStateWrapper(
      child: Scaffold(
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
                      text: "${context.l.hi} ",
                      style: context.textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: "${user.firstName} ${user.lastName}",
                      style: context.textTheme.bodyMedium.bold,
                    ),
                    TextSpan(
                      text: ", ${context.l.ninSuccessPage.successMsg}",
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
          callback: () => finish(),
          text: context.l.okay,
        ),
      ),
    );
  }

  //! MUST update the local profile
  finish() {
    ref.read(futureTrackerProvider).trackAppState(
          future: ProfileManager.instance.fetch(),
          onSuccess: (_) => popBackToPrevApp(widget.user),
          onError: (exc) {
            showSnackbar(
              exc.msg,
              scaffoldMessengerKey: temboNIDASDKMessengerKey,
            );
          },
        );
  }
}
