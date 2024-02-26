import 'package:tembo_nida_sdk/src/extensions/context_extension.dart';

import '../../source.dart';

class TemboBottomButton extends StatelessWidget {
  final VoidCallback callback;
  final String? text;
  final bool loading;

  const TemboBottomButton({
    super.key,
    required this.callback,
    this.text,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.primary,
      child: SafeArea(
        child: TemboTextButton(
          onPressed: callback,
          style: const TemboButtonStyle.filled(borderRadius: 0),
          child: loading
              ? TemboLoadingIndicator(
                  color: context.colorScheme.onPrimary,
                )
              : TemboText(text ?? context.l.next),
        ),
      ),
    );
  }
}
