import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/profile/repository.dart';
import 'package:tembo_nida_sdk/src/logic/session/repo.dart';
import 'package:tembo_nida_sdk/src/views/questions_page.dart';
import 'package:tembo_nida_sdk/src/views/root_app.dart';

import '../../source.dart';

final _pageStateNotifier = createModelStateNotifier<String>();

class SessionPage extends ConsumerStatefulWidget {
  final Profile profile;
  const SessionPage(this.profile, {super.key});

  static const routeName = '/session';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SessionPageState();
}

class _SessionPageState extends TemboConsumerState<SessionPage> {
  Future<String> initiateSession() async {
    final profile = ref.read(profileProvider);
    if (profile == null) {
      throw context.l.profileCheck.error;
    }

    final id = profile.onboardId?.trim() ?? "";
    if (id.isNotEmpty) return id;

    await ref.read(sessionRepoProvider).initiateSession();
    final newProfile = await ref.read(profileRepoProvider).getProfile();
    return newProfile.onboardId!;
  }

  void onPageLoad() {
    final tracker = ref.read(futureTrackerProvider);
    tracker.trackWithNotifier(
      future: initiateSession(),
      notifier: ref.read(_pageStateNotifier.notifier),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    onPageLoad();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_pageStateNotifier);

    ref.listen(_pageStateNotifier, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        success: (_) {
          temboNIDASDKRootNavKey.pop();
          temboNIDASDKRootNavKey.push(
            QuestionsPage(widget.profile),
            routeName: QuestionsPage.name,
          );
        },
      );
    });

    return state.maybeWhen(
      loading: buildLoading,
      error: buildError,
      success: (_) => buildLoading(),
      orElse: buildLoading,
    );
  }

  Widget buildError(TemboException exc) {
    return Scaffold(
      body: Container(
        constraints: kMaxConstraints,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TemboText(context.l.ninStartSession.couldNotStartError),
              vSpace(),
              TemboTextButton.text(
                text: context.l.tryAgain,
                onPressed: onPageLoad,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return const Scaffold(
      body: Center(
        child: TemboLoadingIndicator(),
      ),
    );
  }
}
