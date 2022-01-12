import 'package:flutter/material.dart';

class Utils {
  static double cellHeight = 50.0;

  static String api_url = 'https://atila.online/dev/hores/api/rest';

  static Border borderApp = Border.all(color: Colors.black45, width: 0.5);

  static void confirmAlert(BuildContext context, String title, String detail,
      Function acceptButton) async {
    TextButton cancel = TextButton(
      child: const Text('Cancelar'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    TextButton accept = TextButton(
      child:
          const Text('Aceptar', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () {
        acceptButton();
      },
    );
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(detail)],
            ),
          ),
          actions: <Widget>[cancel, accept],
        );
      },
    );
  }

  static void simpleAlert(
      BuildContext context, String title, String detail) async {
    TextButton cancel = TextButton(
      child: const Text('Ok'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(detail)],
            ),
          ),
          actions: <Widget>[cancel],
        );
      },
    );
  }

  static void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[800],
        elevation: 20.0,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            // this block runs when label is pressed
          },
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        content: Text(
          "$message",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
        ),
      ),
    );
  }

  static void snackBarWarinig(
      BuildContext context, String title, String message) {
    double marginBottom = getCenterScreen(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[700], //Colors.grey[900],
        elevation: 20.0,
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: marginBottom,
        ),
        padding: const EdgeInsets.only(
          left: 20,
          bottom: 10,
          top: 10,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            // this block runs when label is pressed
          },
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: ListTile(
          leading: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white, //Colors.red[300],
            size: 40,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  static void snackBarSuccess(
      BuildContext context, String title, String message) {
    double marginBottom = getCenterScreen(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[700], //Colors.grey[900],
        elevation: 20.0,
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: marginBottom,
        ),
        padding: const EdgeInsets.only(
          left: 20,
          bottom: 10,
          top: 10,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            // this block runs when label is pressed
          },
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: ListTile(
          leading: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white, //Colors.green[300],
            size: 40,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  static void modalLoading(BuildContext context, String texto) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  texto,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static double getAnchoPantalla(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).padding;
    double newWidth = width - padding.left - padding.right;
    double porcAncho = 0.6;
    print('newWidth: $newWidth');
    if (newWidth > 1000) {
      porcAncho = 0.60;
    } else if (newWidth > 800 && newWidth > 600) {
      porcAncho = 0.70;
    } else if (newWidth < 600 && newWidth > 400) {
      porcAncho = 0.80;
    } else if (newWidth < 400) {
      porcAncho = 0.90;
    }
    double ancho = width * porcAncho;
    return ancho;
  }

  static double getAltoPantalla(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    double porcAlto = 0.6;
    print('newheight: $newheight');
    if (newheight > 1000) {
      porcAlto = 0.45;
    } else if (newheight < 800 && newheight > 600) {
      porcAlto = 0.55;
    } else if (newheight < 600 && newheight > 400) {
      porcAlto = 0.65;
    } else if (newheight < 400) {
      porcAlto = 0.85;
    }
    double alto = height * porcAlto;
    return alto;
  }

  static double getCenterScreen(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    double porcAlto = 0.5;

    double alto = newheight * porcAlto;
    return alto;
  }
}
