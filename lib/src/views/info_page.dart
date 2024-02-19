import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tembo_nida_sdk/src/logic/models/profile.dart';
import 'package:tembo_nida_sdk/src/logic/profile/manager.dart';
import 'package:tembo_nida_sdk/src/logic/profile/repository.dart';
import 'package:tembo_nida_sdk/src/view_models/locale_manager.dart';
import 'package:tembo_nida_sdk/src/views/questions_page.dart';
import 'package:tembo_nida_sdk/src/views/root_app.dart';

import '../../source.dart';

import 'qr_code_scanner.dart';

final _profileStateNotifier = createModelStateNotifier<Profile>();

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
                    icon: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Colors.black45,
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
                  /*     TemboTextField.labelled(
                    "Email",
                    controller: state.emailContr,
                    textInputType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ), */
                  Column(
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
                  ),
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

class _NIDANumberPageState extends ConsumerState<BasicInfoPage> {
  late final TextEditingController ninContr, phoneContr, emailContr;
  late DateTime issueDate, expiryDate;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    ninContr = TextEditingController();
    emailContr = TextEditingController();
    phoneContr = TextEditingController();

    issueDate = DateTime.now();
    expiryDate = DateTime.now();

    formKey = GlobalKey<FormState>();
  }

  void updateIssueDate(DateTime date) {
    setState(() => issueDate = date);
  }

  void updateExpiryDate(DateTime date) {
    setState(() => issueDate = date);
  }

  void scanNidaNumber() async {
    final code = await sdkRootNavKey.push3<Barcode?>(const QRCodeScannerPage());
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
      "issueDate": issueDate.toUtc().format("yyyy-MM-ddThh:mm:ss"),
      "expiryDate": expiryDate.toUtc().format("yyyy-MM-ddThh:mm:ss"),
    };

    final futureTracker = ref.read(futureTrackerProvider);
    futureTracker.trackWithNotifier(
      notifier: ref.read(_profileStateNotifier.notifier),
      future: ref.read(profileRepoProvider).updateProfile(data),
      onError: (e) => showSnackbar(e.message.fromLocale(localeManager.value)),
      onSuccess: (e) {
        ref.read(profileProvider.notifier).state = e;
        sdkRootNavKey.push3(const QuestionsPage());
      },
    );
  }

  void next() async {
    final valid = validate();
    if (!valid) return;

    await updateNINNumber();
  }

  @override
  Widget build(BuildContext context) => _NIDANumberPageStateView(this);
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
