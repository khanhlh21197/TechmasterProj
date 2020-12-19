import 'package:flutter/material.dart';

const mainOrange = Color(0xFFF89C1B);
const mainDarkBlue = Color(0xFF004266);
//const mainRed = Color(0xFF9F100F);
const mainRed = Color(0xFFD0021B);
const mainGreen = Color(0xFFB5CC9C);
const mainBackground = Color(0xFFF4F5FB);

const inputBorder = Color(0xFFE0E0E0);
const greyBackground = Color(0xFFF5F5F5);
const greyText = Color(0xFF565656);

Color hexToColor(String code, {Color fallBackColor}) {
	if (code.isEmpty) {
		return fallBackColor ?? Colors.transparent;
	}
	final trimmed = code.trim();
	final tmp = trimmed.startsWith("#") ? trimmed.substring(1) : trimmed;
	final length = tmp.length;
	if (length != 3 && length != 6 && length != 8) {
		return fallBackColor ?? Colors.transparent;
	}
	final a = hexToA(tmp);
	final r = hexToR(tmp);
	final g = hexToG(tmp);
	final b = hexToB(tmp);
	return Color.fromARGB(a, r, g, b);
}
int hexToA(String code) {
	try {
		if (code.length < 8){
			return 255;
		}
		return int.parse(code.substring(0, 2), radix: 16);
	} catch (e) {
		print("hexToA: $e");
		return 0;
	}
}

int hexToR(String code) {
	try {
		final length = code.length;
		if (length == 3) {
			var s = code.substring(0, 1);
			s += s;
			return int.parse(s, radix: 16);
		} else if (length == 6) {
		  return int.parse(code.substring(0, 2), radix: 16);
		} else {
		  return int.parse(code.substring(2, 4), radix: 16);
		}
	} catch (e) {
		print("hexToR: $e");
		return 0;
	}
}

int hexToG(String code) {
	try {
		final length = code.length;
		if (length == 3) {
			var s = code.substring(1, 2);
			s += s;
			return int.parse(s, radix: 16);
		} else if (length == 6) {
		  return int.parse(code.substring(2, 4), radix: 16);
		} else {
		  return int.parse(code.substring(4, 6), radix: 16);
		}
	} catch (e) {
		print("hexToG: $e");
		return 0;
	}
}

int hexToB(String code) {
	try {
		final length = code.length;
		if (length == 3) {
			var s = code.substring(2, 3);
			s += s;
			return int.parse(s, radix: 16);
		} else if (length == 6) {
		  return int.parse(code.substring(4, 6), radix: 16);
		} else {
		  return int.parse(code.substring(6), radix: 16);
		}
	} catch (e) {
		print("hexToB: $e");
		return 0;
	}
}