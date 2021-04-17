import 'package:contacts/core/models/contact.model.dart';
import 'package:contacts/ios/views/address.view.dart';
import 'package:contacts/ios/styles.dart';
import 'package:contacts/ios/views/editor-contact.view.dart';
import 'package:flutter/cupertino.dart';

class DetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text("Contato"),
            trailing: CupertinoButton(
              child: Icon(
                CupertinoIcons.pen,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => EditorContactView(
                      model: ContactModel(
                        id: 1,
                        name: "André Baltieri",
                        email: "andre@balta.io",
                        phone: "11 97214-2255",
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://media-exp1.licdn.com/dms/image/C4D03AQHT446c1pOc_Q/profile-displayphoto-shrink_800_800/0/1589576908763?e=1623888000&v=beta&t=AP2WY5dN0rVAQ3bsBLhjOnrUh7xlHAE24yRZ3V5Gvdc"),
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "André Baltieri",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "11 98741-2282",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "andre@balta.io",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(
                        CupertinoIcons.phone,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(
                        CupertinoIcons.mail,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(
                        CupertinoIcons.photo_camera,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                            ),
                            Text(
                              "Endereço",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Rua do Desenvolvedor, 256",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Piracicaba/SP",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddressView(),
                            ),
                          );
                        },
                        child: Icon(
                          CupertinoIcons.location,
                        ),
                      ),
                    ],
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
