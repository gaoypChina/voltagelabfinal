import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab_v4/Provider/post_provider.dart';
import 'package:voltagelab_v4/pages/search_post_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final searchpost = Provider.of<Postprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          onChanged: (value) {
            searchpost.getsearchpost(value);
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(0, 15, 10, 10),
            suffixIcon: Icon(Icons.search),
            hintText: "Search Anything",
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: searchpost.searchpost.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5)),
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onTap: () {
                  Provider.of<Postprovider>(context, listen: false)
                      .getsearchpostdetails(searchpost.searchpost[index].id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPostDetails(
                          postid: searchpost.searchpost[index].id),
                    ),
                  );
                },
                title: Text(searchpost.searchpost[index].title),
              ),
            ),
          );
        },
      ),
    );
  }
}
