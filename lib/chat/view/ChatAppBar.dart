// import 'package:flutter/material.dart';

// class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final String description;
//   ChatAppBar({@required this.title, @required this.description});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black,
//             blurRadius: 6.0,
//           )
//         ],
//       ),
//       child: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(10),
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(title ?? 'Title'),
//               SizedBox(
//                 height: 5,
//               ),
//               FittedBox(
//                 child: Text(description ??
//                     'Maiores dolor quibusdam esse minus in. Fuga incidunt quaerat temporibus harum nemo impedit quibusdam expedita suscipit. Ut dicta dolore labore consequuntur itaque. Incidunt sed autem ea autem molestiae ducimus.'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(70);
// }
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final String title;
  final String description;
  ChatAppBar({@required this.title, @required this.description});

  int descriptionMaxLines = 3;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color.fromARGB(255, 22, 86, 189),
      expandedHeight: SliverAppBar().toolbarHeight + 16 + (Theme.of(context).textTheme.bodyText2.fontSize * descriptionMaxLines),
      floating: false,
      pinned: true,
      title: Text(title ?? 'Title'),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.only(top: SliverAppBar().toolbarHeight + 16),
          child: Container(
            color: Colors.white.withOpacity(0.1),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              leading: Icon(Icons.info_outline_rounded, color: Colors.white),
              subtitle: Text(
                description ??
                    'Maiores dolor quibusdam esse minus in. Fuga incidunt quaerat temporibus harum nemo impedit quibusdam expedita suscipit. Ut dicta dolore labore consequuntur itaque. Incidunt sed autem ea autem molestiae ducimus.',
                maxLines: descriptionMaxLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
