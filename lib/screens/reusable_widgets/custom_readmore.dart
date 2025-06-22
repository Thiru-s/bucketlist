import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int charLimit;

  const ExpandableText({
    super.key,
    required this.text,
    this.charLimit = 150,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
   /* final words = widget.text.trim().split(RegExp(r'\s+'));
    final hasMore = words.length > widget.wordLimit;*/

    final hasMore = widget.text.length > widget.charLimit;

    final displayedText = _expanded || !hasMore
        ? widget.text
        : '${widget.text.substring(0, widget.charLimit)}... ';


    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: displayedText,
            style: TextStyle(fontSize:10,fontFamily: "Poppins",color: textClr),
          ),
          if (hasMore)
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child:smallText12(context,   _expanded ? '  View less' : '  View more',textColor: Colors.black,fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }
}
