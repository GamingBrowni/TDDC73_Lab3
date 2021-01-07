// Useful links used:
// https://pub.dev/packages/graphql_flutter
// https://docs.github.com/en/free-pro-team@latest/graphql/guides/forming-calls-with-graphql
// https://medium.com/better-programming/how-to-use-graphql-in-flutter-7decd04a511f
// https://medium.com/flutter-community/build-a-github-app-with-flutter-and-graphql-like-a-pro-63f464922196
// https://blog.joshuadeguzman.net/integrating-graphql-in-flutter


import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// My files
import 'package:lab3_flutter/pages/home.dart';

void main() {

  // SET UP DATABASE ----------------------------------------------------------

  final String accessToken = '';

  /*
  OLD CODE THAT DIDN'T WORK:
  --------------------------
  final HttpLink httpLink = HttpLink(uri: "https://api.github.com/graphql");
  final AuthLink authLink = AuthLink(
    getToken: () => 'Bearer <$accessToken>',
  );
  final Link link = authLink.concat(httpLink);
  */

  WidgetsFlutterBinding.ensureInitialized();

  // Added 'accessToken' as String argument in 'client'
  ValueNotifier<GraphQLClient> client(String accessToken) => ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: 'https://api.github.com/graphql',
                      headers: {"authorization": "Bearer $accessToken"}),
    ),
  );

  //---------------------------------------------------------------------------

  // Added 'accessToken' as String argument in 'client'
  runApp(MyApp(client: client(accessToken)));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MyApp({Key key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final textTheme = Theme.of(context).textTheme;

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