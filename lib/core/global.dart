library ppm.globals;

import 'package:flutter/material.dart';

/// Global `BuildContext` used for retrieving providers.
///
/// This should always be set to the `context` which `MaterialApp` lies in.
late BuildContext globalContext;

const String kAppStage = 'Beta Version';
const String kAppStageShort = 'β ';
const int kMajorVersion = 0;
const int kMinorVersion = 1;
const int kPatchVersion = 6;
const int kBuildNumber = 65;
const int kDatabaseVersion = 1;
const String kLastCommitHash = 'a7b61ce9d5afb797beef9053c148946115e3921d';

const String kBundledDataPath = 'assets/json/';
const String kLocalDataPath = '/json/';
late String appSupportPath;

String kDownloadPath = '';
const int kMaxThreads = 3;
