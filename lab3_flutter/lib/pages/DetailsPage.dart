import 'package:flutter/material.dart';

// My files
import 'package:lab3_flutter/RepoData.dart';

class DetailsPage extends StatelessWidget {

  final RepoData repoData;
  DetailsPage(this.repoData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          SizedBox(height: 50.0),

          // --- TITLE ---
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                repoData.title,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // --- DESCRIPTION ---
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                repoData.description,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // --- INFO ---
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // --- LICENSE ---
                    Text(
                      'Owner',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 30.0),

                    // --- COMMITS ---
                    Text(
                      'Commits',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 30.0),

                    // --- BRANCHES ---
                    Text(
                      'Branches',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 30.0),

                    // --- BRANCHES ---
                    Text(
                      'Website:',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // --- FETCHED OWNER DETAIL ---
                    Text(
                      repoData.owner,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(
                      height: 30.0,
                    ),

                    // --- FETCHED COMMITS DETAIL ---
                    Text(
                      repoData.commits.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(
                      height: 30.0,
                    ),

                    // --- FETCHED BRANCH DETAIL ---
                    Text(
                      repoData.branches.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(
                      height: 30.0,
                    ),

                    // --- FETCHED HOMEPAGE DETAIL ---
                    Text(
                      repoData.homepageUrl,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- TILLBAKA BUTTON ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.pinkAccent,
                  child: Container(
                    child: Text(
                      'TILLBAKA',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
