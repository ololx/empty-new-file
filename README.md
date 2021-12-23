# empty-new-file

The Quick Symlink is a `Finder extension`  which provides a `contextual menu item` for the symbolic links creation on macOS. 

[![status](https://img.shields.io/badge/status-active-active?style=flat-square)](BADGES_GUIDE.md#status) [![version](https://img.shields.io/badge/version-0.0.1--alpha.1-informational?style=flat-square)](BADGES_GUIDE.md#version) [![oss lifecycle](https://img.shields.io/badge/oss_lifecycle-active-important?style=flat-square)](BADGES_GUIDE.md#oss-lifecycle) [![maintenance](https://img.shields.io/badge/maintenance-yes-informational?style=flat-square)](BADGES_GUIDE.md#maintenance) [![last release](https://img.shields.io/badge/last_release-November_28,_2021-informational?style=flat-square)](BADGES_GUIDE.md#release-date) [![last commit](https://img.shields.io/badge/last_commit-November_28,_2021-informational?style=flat-square)](BADGES_GUIDE.md#commit-date)

[![license](https://img.shields.io/badge/license-MIT-informational?style=flat-square)](LICENSE) [![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg?style=flat-square)](CODE_OF_CONDUCT.md)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fololx%2Fempty-new-file.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fololx%2Fempty-new-file?ref=badge_shield)

[![platform](https://img.shields.io/badge/platform-OS_X_10.10+-important?style=flat-square)](https://en.wikipedia.org/wiki/Computing_platform)

---

## 📇 Table of Contents

- [About](#-about-)
- [Demo](#-demo-)
- [Features](#-feature-)
- [Getting Started](#-getting-started-)
- [Built With](#-built-with-)
- [Contributing](#-contributing-)
- [Code of Conduct](#-code-of-conduct-)
- [Versioning](#-versioning-)
- [Authors](#-authors-)
- [Licensing](#-licensing-)

##  📖 About

The Empty New File is a Finder Extension  which allows to create an empty new file. It could be called by right-clicking on selected folders or files and selecting `New File` from the contextual menu.

### Motivation

Sometimes I just want to create a new file through the context menu as in Windows.

## 📸 Demo

This GIF demonstrates how the `Empty New File` allows quite simple to create an empty new file in the current directory.

<img src="https://github.com/ololx/empty-new-file/blob/assets/demo/empty-new-file-demo-1.gif?raw=true" width="100%"/>

This PIC demonstrates how the `Empty New File` allows to select files extensions for the creating an empty new file.

<img src="https://github.com/ololx/empty-new-file/blob/assets/empty-new-file-setup-ext.png?raw=true" width="50%"/>

## 🎚 Features

- Create an empty new file in a several clicks via the context menu.

### To Do

- For more information on an upcoming development, please read the [todo](TODO.md) list.

### Changelog

- For more information on releases, features and changes, please read the [changelog](CHANGELOG.md) notes.

## 🚦 Getting Started

These instructions allow to get a copy of this project and run it on a local machine.

### Prerequisites

Before using it, make sure that follows software are installed on the local machine:

- **[OS X 10.10+](https://www.apple.com/ru/macos/what-is/)** - the operating system under which the extention is executing.

If any of the listed programs is not installed, then it can be installed by instruction as described below.

1. #### OS X 10.10+
    - Install macOS 10.10+  by [this](https://support.apple.com/ht201372) instruction.

### Installing

In order to install it is quite simple to:

1. Download executable file from releases (or compile it from the sources).
2. Go to the directory where you download this tool (optionally):

   - via Finder.
   - via Terminal prompt.

   ```bash
   cd /{path to parent dir with this tool}/
   ```

3. Launch the tool in macOS (optionally):

   - via double-click on `empty-new-file.app`.
   - via Terminal prompt.

   ```bash
   open empty-new-file.app
   ```

4. Open up `System Preferences > Extensions` and enable the `empty-new-file-menu`.

**Otherwise, it's possible to install and remove the extention using the actual extension bundled into the app.**

1. To install and approve the extension, run this:

```bash
pluginkit -a empty-new-file.app/Contents/PlugIns/empty-new-file-menu.appex/
```

2. To remove it, run this:

```bash
pluginkit -r empty-new-file.app/Contents/PlugIns/empty-new-file-menu.appex/
```

### Downloading

For the downloading executable file or sources to a local machine, just use the follows link and choose a required release:

```http
https://github.com/ololx/empty-new-file/releases/
```

### Cloning

For the cloning this repository to a local machine, just use the follows link:

```http
https://github.com/ololx/empty-new-file.git
```

## 🛠 Built With

- **[Xcode](https://developer.apple.com/xcode/)** - the IDE for the `Finder Sync Extension` development.

## 🎉 Contributing

If you want to contribute this project - you are welcome and have fun.
Please visit the [contributing](CONTRIBUTING.md) section for details on this code of conduct, and the process for submitting pull requests.

## 📝 Code of Conduct

In order to ensure that all is welcoming, please review and abide by the [code of conduct](CODE_OF_CONDUCT.md).

## 🗒 Versioning

For the versioning is used [Semantic Versioning](http://semver.org/). For the versions available, see the [changelog](CHANGELOG.md) or the tags on this repository.

## ©️ Authors

* **Alexander A. Kropotin** - *Initial work* - [ololx](https://github.com/ololx).

## 🔏 Licensing

This project is licensed under the MIT license - see the [lisence](LICENSE) document for details.


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fololx%2Fempty-new-file.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fololx%2Fempty-new-file?ref=badge_large)