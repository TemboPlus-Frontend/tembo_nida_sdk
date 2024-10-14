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
      color: Colors.white,
      child: SafeArea(
          child: Padding(
        padding: horizontal(20) + bottom(60),
        child: TemboTextButton(
          onPressed: callback,
          style: TemboButtonStyle.filled(
            padding: horizontal() + vertical(),
            borderRadius: 40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TemboText.headlineSmall(
                context,
                text ?? "Next",
                color: getTemboColorScheme().onPrimary,
                weight: FontWeight.bold,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

