library tembo_nida_sdk;

import 'package:tembo_nida_sdk/src/view_models/navigator_manager.dart';

import 'source.dart';
import 'src/views/root_app.dart';
import 'src/views/toc_page.dart';
import 'tembo_nida_sdk.dart';

export "./src/logic/models/user.dart";

NavigatorState get prevAppRootNav => prevAppNavManager.value;

Future<NIDAUser?> startNIDAVerProcess(BuildContext context) async {
  initNavigatorManager(context);
  return await pushApp(context, "toc", const TOCPage());
}
