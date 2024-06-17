import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tembo_nida_sdk/src/logic/profile/repository.dart';
import 'package:tembo_nida_sdk/src/view_models/locale_manager.dart';
import 'package:tembo_nida_sdk/src/views/root_app.dart';

import '../../source.dart';

import 'qr_code_scanner.dart';
import 'session_page.dart';

final _profileStateNotifier = createModelStateNotifier<Profile>();
final _firstTimeProfileStateNotifier = createModelStateNotifier<Profile>();

class BasicInfoPage extends ConsumerStatefulWidget {
  const BasicInfoPage({super.key});

  static const name = "nin";

  @override
  ConsumerState<BasicInfoPage> createState() => _NIDANumberPageState();
}

class _NIDANumberPageStateView extends ConsumerWidget {
  final _NIDANumberPageState state;
  const _NIDANumberPageStateView(this.state);

  @override
  Widget build(BuildContext context, ref) {
    final profileState = ref.watch(_firstTimeProfileStateNotifier);

    return profileState.maybeWhen(
      loading: buildLoading,
      error: buildError,
      success: (data) => buildBody(context, ref),
      orElse: buildLoading,
    );
  }

  Widget buildError(TemboException exc) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Container(
          constraints: kMaxConstraints,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TemboText(context.l.profileCheck.error),
                vSpace(),
                TemboTextButton.text(
                  text: context.l.tryAgain,
                  onPressed: state.fetchProfile,
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildLoading() {
    return const Scaffold(
      body: Center(
        child: TemboLoadingIndicator(),
      ),
    );
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: TemboAppBar(label: context.l.ninInfoPage.title),
      body: FocusWrapper(
        child: Form(
          key: state.formKey,
          child: ListView(
            padding: kPagePadding,
            children: [
              TemboTextField.labelled(
                context.l.ninInfoPage.nin,
                controller: state.ninContr,
                formatters: const [
                  OnlyIntegerFormatter(),
                  FixedLengthFormatter(20)
                ],
                validator: _validateNIDANumber,
                textInputType: TextInputType.number,
                decoration: TemboTextFieldDecoration(
                  suffixIcon: IconButton(
                    onPressed: state.scanNidaNumber,
                    icon: Icon(
                      Icons.qr_code_scanner_rounded,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              /*  vSpace(),
              TemboTextField.labelled(
                context.l.email,
                controller: state.emailContr,
                textInputType: TextInputType.emailAddress,
                validator: validateEmail,
              ) */
            ],
          ),
        ),
      ),
      bottomNavigationBar: TemboBottomButton(
        callback: state.next,
        text: context.l.next,
        loading: ref.watch(_profileStateNotifier).isLoading,
      ),
    );
  }
}

class _NIDANumberPageState extends TemboConsumerState<BasicInfoPage> {
  late final TextEditingController ninContr, emailContr;

  late final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) => _NIDANumberPageStateView(this);

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    fetchProfile();
  }

  @override
  void initState() {
    super.initState();
    ninContr = TextEditingController();
    emailContr = TextEditingController();

    formKey = GlobalKey<FormState>();
  }

  Future<void> fetchProfile() async {
    final futureTracker = ref.read(futureTrackerProvider);
    futureTracker.trackWithNotifier(
      notifier: ref.read(_firstTimeProfileStateNotifier.notifier),
      future: ref.read(profileRepoProvider).getProfile(),
      onError: (e) => showSnackbar(e.message.fromLocale(localeManager.value)),
      onSuccess: (e) {
        ref.read(profileProvider.notifier).state = e;

        setState(() {
          emailContr.text = e.email ?? "";
          ninContr.text = e.nin ?? "";
        });
      },
    );
  }

  void scanNidaNumber() async {
    final code = await temboNIDASDKRootNavKey.push<Barcode?>(
      const QRCodeScannerPage(),
      routeName: QRCodeScannerPage.name,
    );
    if (code == null) return;
    if (code.type == BarcodeType.text) {
      ninContr.text = code.displayValue ?? "";
    }
  }

  bool validate() {
    final valid = formKey.currentState?.validate() ?? false;
    return valid;
  }

  Future<void> updateNINNumber() async {
    final date = DateTime.now().toUtc().format("yyyy-MM-dd'T'HH:mm:ss'Z'");
    final data = {
      "cardIssueDate": date,
      "cardExpiryDate": date,
      "nin": ninContr.compactText!,
    };

    final futureTracker = ref.read(futureTrackerProvider);
    futureTracker.trackWithNotifier(
      notifier: ref.read(_profileStateNotifier.notifier),
      future: ref.read(profileRepoProvider).updateProfile(data),
      onError: (e) => showSnackbar(e.message.fromLocale(localeManager.value)),
      onSuccess: (profile) {
        ref.read(profileProvider.notifier).state = profile;
        temboNIDASDKRootNavKey.push(
          SessionPage(profile),
          routeName: SessionPage.routeName,
        );
      },
    );
  }

  void next() async {
    final valid = validate();
    if (!valid) return;

    await updateNINNumber();
  }
}

Message? _validateNIDANumber(String? text) {
  if (text == null || text.trim().isEmpty) {
    return const Message(
      enMessage: 'NIDA number can\'t be empty',
      swMessage: 'Lazima uweke namba ya NIDA',
    );
  }

  if (text.trim().length != 20) {
    return const Message(
      enMessage: 'Invalid NIDA number',
      swMessage: 'Namba ya NIDA si sahihi',
    );
  }

  return null;
}
