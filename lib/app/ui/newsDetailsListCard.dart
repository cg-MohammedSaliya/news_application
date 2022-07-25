import 'package:flutter/material.dart';

class NewsDetailsListCard extends StatelessWidget {
  const NewsDetailsListCard({
    Key? key,
    required this.newsImage,
    required this.newsTittle,
    required this.newsContent,
    required this.onPressed,
  }) : super(key: key);

  final String newsImage;
  final String newsTittle;
  final String newsContent;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
              onTap: onPressed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newsImage.isNotEmpty
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                          child: Image.network(newsImage),
                        )
                      :  const SizedBox(
                          child: Center(
                            child: Image(
                              image: AssetImage('assest/images/img.png'),
                            )

                          ),
                        ),
                  newsTittle.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            newsTittle,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )
                      : const SizedBox(),
                  newsContent.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(newsContent),
                        )
                      : const SizedBox(),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
      ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
}
