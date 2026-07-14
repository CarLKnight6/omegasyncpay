// import 'package:flutter/material.dart';

// import '../utils/constants.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final Function? onPressed;
//   final double? elevation;
//   final int? borderRadius;
//   final EdgeInsets? padding;
//   final double? textSize;
//   final Color? fillColor;

//   const CustomButton({
//     Key? key,
//     required this.text,
//     required this.onPressed,
//     this.fillColor,
//     this.elevation,
//     this.borderRadius,
//     this.padding,
//     this.textSize,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return RawMaterialButton(
//       onPressed: onPressed as void Function()?,
//       elevation: elevation ?? 0,
//       fillColor: fillColor ?? StyleDictionaryColor.systemColorsPrimaryMain,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius as double? ?? 4)),
//       child: Padding(
//         padding: padding ??
//             const EdgeInsets.only(top: 9, bottom: 10, left: 16, right: 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               text,
//               style: Theme.of(context).textTheme.labelLarge!.copyWith(
//                   color: Colors.white,
//                   fontSize: textSize ??
//                       Theme.of(context).textTheme.labelLarge!.fontSize),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
