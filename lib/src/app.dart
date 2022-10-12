import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sample_bloc/src/features/detailed_news/bloc/detailed_news_bloc.dart';
import 'package:flutter_sample_bloc/src/features/detailed_news/view/detailed_news_page.dart';
import 'package:flutter_sample_bloc/src/features/detailed_news/view/detailed_news_page_args.dart';
import 'package:flutter_sample_bloc/src/features/navigation/view/navigation_page.dart';
import 'package:flutter_sample_bloc/src/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: theme,
      home: const NavigationPage(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case DetailedNewsPage.routeName:
                {
                  final args = routeSettings.arguments as DetailedNewsPageArgs;
                  return BlocProvider(
                    create: (context) => DetailedNewsBloc(news: args.news),
                    child: const DetailedNewsPage(),
                  );
                }
              default:
                throw ('Undefined route');
            }
          },
        );
      },
    );
  }
}
