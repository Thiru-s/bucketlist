
import '../../utils/resources/resource_imports.dart';

BoxDecoration commonCardDecoration({Color color = Colors.white}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        offset: const Offset(1, 2),
        blurRadius: 5,
        spreadRadius: 0,
      ),
    ],
  );
}
