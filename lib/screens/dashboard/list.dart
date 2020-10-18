import 'package:beerbiceps/constants/db.dart';
import 'package:beerbiceps/queries/query/blogsdata.dart';
import 'package:beerbiceps/screens/blog/favourite.dart';
import 'package:beerbiceps/screens/dashboard/info.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';

class BlogList extends StatefulWidget {
  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    return ListStyle();
  }
}

class ListStyle extends StatelessWidget {
  const ListStyle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Database.instance.graphQLProvider(
        child: Query(
            options: QueryOptions(documentNode: gql(allData)),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.loading) {
                return Image.network(
                    'https://beerbiceps2.adesignguy.co/wp-content/uploads/2020/09/0M-Recovered-1-1.gif');
              }
              print(result.data['posts']['nodes']);
              print("whatttt " +
                  result.data['posts']['nodes'][0]['author']['node']
                      ['firstName']);
              return ListView.builder(
                  itemCount: result.data['posts']['nodes'].length,
                  itemBuilder: (context, index) {
                    print("LOL " +
                        result.data['posts']['nodes'][index].toString());
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullData(),
                              settings: RouteSettings(
                                  arguments: result.data['posts']['nodes']
                                          [index]
                                      .toString())),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 30, bottom: 30),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(result.data['posts']['nodes'][index]
                                        ['title']),
                                    SizedBox(height: 10),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      height: 2,
                                      width: 50,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      result.data['posts']['nodes'][index]
                                          ['author']['node']['firstName'],
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FavouritePage()));
        },
        child: Icon(Icons.favorite),
      ),
    );
  }
}
