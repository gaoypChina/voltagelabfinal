import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/Screen/Voltage_Lab/MCQ/mcq_postlist_page.dart';
import 'package:voltagelab/helper/global.dart';
import 'package:voltagelab/pages/post_page.dart';

class McqSubcategoryPAge extends StatefulWidget {
  final int categoryid;
  final String categoryname;
  final String sitename;
  const McqSubcategoryPAge(
      {Key? key,
      required this.categoryid,
      required this.categoryname,
      required this.sitename})
      : super(key: key);

  @override
  _McqSubcategoryPAgeState createState() => _McqSubcategoryPAgeState();
}

class _McqSubcategoryPAgeState extends State<McqSubcategoryPAge> {
  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.categoryname,
          style: Global.bnPostListAppbarText,
        ),
      ),
      body: category.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: category.mcqsubcategory.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => McqPostlistPage(
                                            sitename: widget.sitename,
                                            categoryid: category
                                                .mcqsubcategory[index].id!,
                                            categoryname: category
                                                .mcqsubcategory[index].name!)));
                              },
                              borderRadius: BorderRadius.circular(5),

                              // new code
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    // height: 80,
                                    // width: 80,
                                    decoration: BoxDecoration(
                                      // color: color,
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        'images/logo-icon-category.png',
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      category.mcqsubcategory[index].name!,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style: Global.bnListTitleText,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 5),
                        // Expanded(
                        //   child: Container(
                        //     margin: const EdgeInsets.all(5),
                        //     child: Text(
                        //       category.mcqsubcategory[index].name!,
                        //       // maxLines: 1,
                        //       // overflow: TextOverflow.ellipsis,
                        //     ),
                        //   ),
                        // )
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
