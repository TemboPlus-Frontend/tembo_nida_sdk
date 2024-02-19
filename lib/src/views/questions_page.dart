import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/models/question.dart';
import 'package:tembo_nida_sdk/src/logic/verify/manager.dart';
import 'package:tembo_nida_sdk/src/views/root_app.dart';
import 'package:tembo_nida_sdk/src/views/success_page.dart';

import '../../source.dart';
import '../logic/models/user.dart';
import 'failure_page.dart';

typedef _State = ({NIDAUser? user, Question? newQn});

final _pageStateNotifier = createModelStateNotifier<_State>();

final class QuestionsPage extends TemboConsumerPage {
  const QuestionsPage({super.key});

  @override
  String get name => "questions-page";

  @override
  ConsumerState<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageStateView extends ConsumerWidget {
  final _QuestionsPageState state;
  const _QuestionsPageStateView(this.state);

  @override
  Widget build(BuildContext context, ref) {
    final pageState = ref.watch(_pageStateNotifier);
    return pageState.when(
      initial: buildLoading,
      loading: buildLoading,
      success: buildSuccess,
      error: (_) => buildError(),
    );
  }

  Widget buildError() {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: TemboAppBar(),
        body: TemboContainer(
          constraints: kMaxConstraints,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TemboText("An error happened"),
              vSpace(),
              TemboTextButton(
                onPressed: state.retry,
                child: TemboText(context.loc.tryAgain),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildLoading() {
    return Scaffold(
      appBar: TemboAppBar(),
      body: TemboContainer(
        constraints: kMaxConstraints,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("packages/tembo_nida_sdk/assets/laoding.gif")],
        ),
      ),
    );
  }

  Widget buildSuccess(_State data) {
    if (data.newQn != null) return buildQuestion(data.newQn!);

    return buildLoading();
  }

  Widget buildQuestion(Question qn) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: TemboAppBar(label: "Jibu Maswali"),
        body: FocusWrapper(
          child: ListView(
            padding: kPagePadding,
            children: [
              // const TemboFormLabel("Question (English)"),
              // buildQn(qn.inEnglish),
              // vSpace(),
              TemboLabel(
                "Swali: ",
                style: context.textTheme.bodyLarge.bold.withPrimaryColor,
              ),
              buildQn(qn.inSwahili),
              vSpace(),
              TemboTextField.labelled(
                "Jibu:",
                controller: state.answerController,
                textCapitalization: TextCapitalization.words,
              )
            ],
          ),
        ),
        bottomNavigationBar: TemboBottomButton(
          callback: state.sendAnswer,
          text: "Send Answer",
        ),
      );
    });
  }

  Widget buildQn(String data) {
    return Builder(builder: (context) {
      return TemboText(
        data,
        style: context.textTheme.bodyMedium.withFW600.withColor(
          context.colorScheme.onSurface,
        ),
      );
    });
  }
}

class _QuestionsPageState extends TemboConsumerState<QuestionsPage> {
  final answerController = TextEditingController();

  VoidCallback? callback;

  @override
  Widget build(BuildContext context) => _QuestionsPageStateView(this);

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    loadFirstQuestion();
  }

  void retry() {
    if (callback == null) return;

    callback!();
  }

  void loadFirstQuestion() {
    callback = loadFirstQuestion;
    final futureTracker = ref.read(futureTrackerProvider);

    Future<_State> future() async {
      final result =
          await ref.read(verManagerProvider.notifier).getFirstQuestion();
      return (user: null, newQn: result);
    }

    futureTracker.trackWithNotifier(
      future: future(),
      notifier: ref.read(_pageStateNotifier.notifier),
      onSuccess: (p0) => answerController.clear(),
    );
  }

  bool validate() {
    if (answerController.compactText == null) {
      showSnackbar("Tafadhari andika jibu sahihi");
      return false;
    }

    return true;
  }

  void sendAnswer() {
    final valid = validate();
    if (!valid) return;

    final futureTracker = ref.read(futureTrackerProvider);

    futureTracker.trackWithNotifier(
      notifier: ref.read(_pageStateNotifier.notifier),
      future: ref.read(verManagerProvider.notifier).sendAnswer(
            ref.read(_pageStateNotifier).data!.newQn!,
            answerController.compactText!,
          ),
      onSuccess: (data) {
        answerController.clear();

        if (data.user == null && data.newQn == null) {
          sdkRootNavKey.push(const FailurePage());
          return;
        }

        if (data.user != null) {
          sdkRootNavKey.pop();
          sdkRootNavKey.push(SuccessPage(data.user!));
        }
      },
    );
  }
}
