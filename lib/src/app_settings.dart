import 'dart:io';

const defaultLocaleName = 'us';

bool get isMobile => Platform.isAndroid || Platform.isIOS;

bool get isDesktop =>
    Platform.isLinux || Platform.isMacOS || Platform.isWindows;
