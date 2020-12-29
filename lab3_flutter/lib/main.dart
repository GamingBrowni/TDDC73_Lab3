// Useful links used:
// https://pub.dev/packages/graphql_flutter
// https://docs.github.com/en/free-pro-team@latest/graphql/guides/forming-calls-with-graphql
// https://medium.com/better-programming/how-to-use-graphql-in-flutter-7decd04a511f
// https://medium.com/flutter-community/build-a-github-app-with-flutter-and-graphql-like-a-pro-63f464922196
// https://blog.joshuadeguzman.net/integrating-graphql-in-flutter


import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lab3_flutter/pages/details.dart';
import 'package:lab3_flutter/pages/home.dart';
//import 'package:lab3_flutter/data.dart';

void main() {

  // SET UP DATABASE ----------------------------------------------------------

  final HttpLink httpLink = HttpLink(uri: "https://api.github.com/graphql");

  WidgetsFlutterBinding.ensureInitialized();

  //final String accessToken = "b0f11a5b42b88acd23d75b11c09aacb4b852c644";
  // fed42545a22a8fd60bdb78f711bc64d4e28a777d

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <fed42545a22a8fd60bdb78f711bc64d4e28a777d>',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );

  //---------------------------------------------------------------------------

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MyApp({Key key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          home: Home(),
        ),
      ),
    );
  }
}