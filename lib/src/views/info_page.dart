import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tembo_nida_sdk/src/logic/models/profile.dart';
import 'package:tembo_nida_sdk/src/logic/profile/repository.dart';
import 'package:tembo_nida_sdk/src/view_models/locale_manager.dart';
import 'package:tembo_nida_sdk/src/views/root_app.dart';

import '../../source.dart';

import 'qr_code_scanner.dart';
import 'session_page.dart';

final _profileStateNotifier = createModelStateNotifier<Profile>();
final _firstTimeProfileStateNotifier = createModelStateNotifier<Profile>();

class BasicInfoPage extends TemboConsumerPage {
  const BasicInfoPage({super.key});

  @override
  String get name => "nin";

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
      body: Container(
        constraints: kMaxConstraints,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TemboText("We could not fetch your profile"),
              vSpace(),
              TemboTextButton.text(
                text: "Try Again",
                onPressed: state.fetchProfile,
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

  Widget buildBody(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: TemboAppBar(label: "Taarifa zako"),
      body: FocusWrapper(
        child: Form(
          key: state.formKey,
          child: ListView(
            padding: kPagePadding,
            children: [
              TemboTextField.labelled(
                "Namba ya NIDA",
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
              vSpace(),
              OverflowBar(
                spacing: 20,
                overflowSpacing: 20,
                children: [
                  TemboTextField.labelled(
                    "Phone",
                    controller: state.phoneContr,
                    textInputType: TextInputType.phone,
                    formatters: const [
                      OnlyIntegerFormatter(),
                      FixedLengthFormatter(10)
                    ],
                    validator: validateTZPhone,
                  ),
                 /*  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TemboLabel("Card Issue Date"),
                      TemboDatePicker(
                        date: state.issueDate,
                        label: (d) => d.format(),
                        onSelected: state.updateIssueDate,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TemboLabel("Card Expiry Date"),
                      TemboDatePicker(
                        date: state.expiryDate,
                        label: (d) => d.format(),
                        onSelected: state.updateExpiryDate,
                      ),
                    ],
                  ), */
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: TemboBottomButton(
        callback: state.next,
        text: context.loc.next,
        loading: ref.watch(_profileStateNotifier).isLoading,
      ),
    );
  }
}

class _NIDANumberPageState extends TemboConsumerState<BasicInfoPage> {
  late final TextEditingController ninContr, phoneContr, emailContr;
  late DateTime issueDate, expiryDate;

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
    phoneContr = TextEditingController();

    issueDate = DateTime.now();
    expiryDate = DateTime.now();

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
          phoneContr.text =
              e.phone?.getNumberWithFormat(MobileNumberFormat.s0) ?? "";
          issueDate = e.cardIssueDate ?? DateTime.now();
          expiryDate = e.cardExpiryDate ?? DateTime.now();
          ninContr.text = e.nin ?? "";
        });
      },
    );
  }

  void updateIssueDate(DateTime date) {
    setState(() => issueDate = date);
  }

  void updateExpiryDate(DateTime date) {
    setState(() => issueDate = date);
  }

  void scanNidaNumber() async {
    final code =
        await temboNIDASDKRootNavKey.push3<Barcode?>(const QRCodeScannerPage());
    if (code == null) return;
    if (code.type == BarcodeType.text) {
      ninContr.text = code.displayValue ?? "";
    }
  }

  bool validate() {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      final phone = PhoneNumber.from(phoneContr.compactText ?? "");
      if (phone == null) {
        showSnackbar("Invalid phone number");
        return false;
      }
    }

    return valid;
  }

  Future<void> updateNINNumber() async {
    final phone = PhoneNumber.from(phoneContr.compactText!);
    final data = {
      "nin": ninContr.compactText!,
      "phone": phone!.getNumberWithFormat(MobileNumberFormat.s255),
      "cardIssueDate": issueDate.toUtc().format("yyyy-MM-ddThh:mm:ss"),
      "cardExpiryDate": expiryDate.toUtc().format("yyyy-MM-ddThh:mm:ss"),
    };

    final futureTracker = ref.read(futureTrackerProvider);
    futureTracker.trackWithNotifier(
      notifier: ref.read(_profileStateNotifier.notifier),
      future: ref.read(profileRepoProvider).updateProfile(data),
      onError: (e) => showSnackbar(e.message.fromLocale(localeManager.value)),
      onSuccess: (e) {
        ref.read(profileProvider.notifier).state = e;
        temboNIDASDKRootNavKey.to(SessionPage.routeName, const SessionPage());
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
