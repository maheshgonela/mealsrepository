import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class foodtruelist extends StatefulWidget {
  const foodtruelist({super.key});

  @override
  State<foodtruelist> createState() => _foodtruelistState();
}

List<String> emailList = [];

class _foodtruelistState extends State<foodtruelist> {
  var now = DateTime.now();
  bool _isLoading = false;
  Future<void> foremaillilst() async {
    FirebaseFirestore.instance
        .collection('lunch_${now.day}-${now.month}-${now.year}')
        .where('date', isEqualTo: '${now.day}-${now.month}-${now.year}')
        .where('lunch', isEqualTo: true)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        var docs = querySnapshot.docs;

        docs.forEach((doc) {
          String email = doc['email'];
          emailList.add('$email');
        });
        print(emailList);

        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  void initState() {
    emailList.clear();
    foremaillilst();
    _isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromRGBO(191, 226, 220, 1),
        title: Text(
          'Food',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 21,
                color: Colors.black,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: EmailSearchDelegate(emailList),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                itemCount: emailList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.grey[300],
                    margin: EdgeInsets.only(top: 3),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          emailList[index].substring(0, 2),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      title: Text(
                        emailList[index],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class EmailSearchDelegate extends SearchDelegate<String> {
  final List<String> emailList;

  EmailSearchDelegate(this.emailList);

  @override
  String get searchFieldLabel => 'Search Emails';
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        color: Color.fromRGBO(191, 226, 220, 1),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back, color: Colors.black),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredEmails =
        emailList.where((email) => email.contains(query)).toList();

    return ListView.builder(
      itemCount: filteredEmails.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            filteredEmails[index],
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestedEmails =
        emailList.where((email) => email.contains(query)).toList();

    return ListView.builder(
      itemCount: suggestedEmails.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return Container(
          child: Container(
            color: Colors.grey[300],
            margin: EdgeInsets.only(top: 3),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  suggestedEmails[index].substring(0, 2),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                ),
              ),
              title: Text(
                suggestedEmails[index],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      color: Colors.black,
                    ),
              ),
              onTap: () {
                close(context, suggestedEmails[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
