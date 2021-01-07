import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// My files
import 'package:lab3_flutter/pages/DetailsPage.dart';
import 'package:lab3_flutter/RepoData.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String languageQuery = 'python';
  String sortChoice;

  List sortList = [
    "JavaScript",
    "TypeScript",
    "Go",
    "Rust",
    "Swift",
    "Web",
    "PHP",
    "CSS",
    "C",
    "C#",
    "C++",
    "Python",
    "Ruby",
    "Java"
  ];

  final String readRepositories = """
  query trendingRepos(\$queryString: String!) {
    search(query: \$queryString, type: REPOSITORY, first: 10) {
      nodes {
        ... on Repository {
          id
          name
          description
          homepageUrl
          owner {
            url
            login
            ... on Organization {
              login
            }
          }
          stargazers {
            totalCount
          }
          forks {
            totalCount
          }
          commitComments {
            totalCount
          }
          branchProtectionRules {
            totalCount
          }
        }
      }
    }
  }
""";

  RepoData generateRepoObj(objectItem) {
    String title = objectItem["name"];
    String description = objectItem["description"];
    String homepageUrl = objectItem["homepageUrl"];
    String owner = objectItem["owner"]["login"];
    //String ownerOrg = objectItem["owner"]["organization"]["login"];
    int stargazers = objectItem["stargazers"]["totalCount"];
    int forks = objectItem["forks"]["totalCount"];
    int commits = objectItem["commitComments"]["totalCount"];
    int branches = objectItem["branchProtectionRules"]["totalCount"];

    return new RepoData(title, description, homepageUrl, owner, stargazers,
    forks, commits, branches);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(readRepositories), // this is the query string you just created
          variables: {'queryString': 'language:$languageQuery stars:>1000' },
        ),

        builder: (QueryResult result,
            { VoidCallback refetch, FetchMore fetchMore }) {

          // Errors??
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          // Data is loading
          if (result.loading) {
            return Text('Loading');
          }

          //List repositories = result.data['search']['nodes'];

          // Create a list 'repositories' of RepoData objects
          // to ease searching for them & sending them to DetailsPage.dart
          List<RepoData> repositories = new List();
          for(var repository in result.data['search']['nodes']) {
            repositories.add(generateRepoObj(repository));
          }

          // Everything loaded correctly:
          return Column(
            children: [
              Expanded(
                flex: 10,
                child: ListView.builder(
                    itemCount: repositories.length,
                    itemBuilder: (context, index) {

                      // Get the repository at slot 'index'
                      final repository = repositories[index];

                      return Card(
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                            child: Column(
                              children: [
                                Align(
                                  // --- TITLE of repo ---
                                    alignment: Alignment.topLeft,
                                    child: Text(repository.title,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),)
                                ),
                                SizedBox(height: 2.0),

                                // --- OWNER of repo ---
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(repository.owner,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[800],
                                      ),)
                                ),
                                SizedBox(height: 8.0),

                                // --- DESCRIPTION of repo ---
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(repository.description,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                    ),),
                                ),
                                SizedBox(height: 4.0),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    // --- FORKS ---
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text('Forks ',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(repository.forks.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),),
                                      ),
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.pink[300],
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(5.0),
                                          )
                                      ),
                                      child: Row(
                                        children: [

                                          // --- STARS ---
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 2.0, 4.0),
                                              child: Text('Stars ',
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(4.0, 4.0, 2.0, 4.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(repository.stargazers.toString(),
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // -- Navigate to new page (details page) on-click --
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(builder: (context) => DetailsPage(repository)));
                          },
                        ),
                      );
                    }
                ),
              ),

              // --- SORT DATA BY ---
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.pink[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 2, 0, 0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Sort by',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(height:4.0),

                            // --- DROP DOWN BUTTON ---------------------------
                            Container(
                              height: 14.0,
                              child: DropdownButton(
                                hint: Text('$languageQuery'),
                                isExpanded: true,
                                underline: SizedBox(),
                                iconEnabledColor: Colors.white,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                value: sortChoice,
                                onChanged: (sortInput) {
                                  setState(() {
                                    sortChoice = sortInput;
                                    // Change language in query
                                    languageQuery = sortChoice;
                                  });
                                },
                                items: sortList.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
          },
      ),
    );
  }
}
