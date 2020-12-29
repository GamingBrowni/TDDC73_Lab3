import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lab3_flutter/pages/details.dart';
import 'package:lab3_flutter/main.dart';


/*
* owner {
                      url
                    }
                    description
                    forks{
                      totalCount
                    }
                    homepageUrl
                    stargazers {
                      totalCount
                    }
                    owner {
                      login
                      ... on Organization {
                        login
                      }
                    }
                    primaryLanguage {
                      name
                    }
                    commitComments {
                      totalCount
                    }
                    branchProtectionRules {
                      totalCount
                    }
                  }*/


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String defaultChoice = 'Python';
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
    "Java",
    "Trending: Stars",
  ];

  //int nRepositories = 20;

  String readRepositories = """
  query ReadRepositories(\$nRepositories: Int!) {
    viewer {
      repositories(last: \$nRepositories) {
        nodes {
          id
          name
          viewerHasStarred
        }
      }
    }
  }
""";

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
          variables: {
            'nRepositories': 5,
          },
          pollInterval: 10,
        ),
        // Just like in apollo refetch() could be used to manually trigger a refetch
        // while fetchMore() can be used for pagination purpose
        builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.loading) {
            return Text('Loading');
          }
          // it can be either Map or List
          List repositories = result.data['viewer']['repositories']['nodes'];
          return ListView.builder(
              itemCount: repositories.length,
              itemBuilder: (context, index) {
                final repository = repositories[index];
                return Text(repository['name']);
              });
        },
      ),


      /*Query(
        options: QueryOptions(
          documentNode: gql('''
          query Trending (\$queryString: String!){
            search(query:\$queryString, type: REPOSITORY , first:20) {
              nodes {
                  ... on Repository {
                    id
                    name
                    url
                   }
              }
            }
          }
          '''),
        ),

        builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.errors != null) {
            return Text(result.errors.toString());
          }

          if (result.loading) {
            return Text('Loading');
          }

          // it can be either Map or List
          List people = result.data['getPeople'];

          return ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                final repository = people[index];

                return Text(people['name']);
              });
        },
      ),*/

      /*Column(
        children: [
          Expanded(
            flex: 10,
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                              child: Text(dataList[index].title,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),)
                          ),
                          SizedBox(height: 2.0),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(dataList[index].developer,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[800],
                              ),)
                          ),
                          SizedBox(height: 8.0),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(dataList[index].description,
                            style: TextStyle(
                              fontSize: 13.0,
                            ),),
                          ),
                          SizedBox(height: 4.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                                  child: Text('685',
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
                                        child: Text('25596',
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailsPage()));
                    },
                  ),
                );
              }
            ),
          ),

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

                        // --- DROP DOWN BUTTON -------------------------------
                        Container(
                          height: 14.0,
                          child: DropdownButton(
                            hint: Text('$defaultChoice'),
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
      ),*/
    );
  }
}
