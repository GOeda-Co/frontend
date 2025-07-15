<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h3 align="center">Repeatro Frontend</h3>
  <p align="center">
    A modern Flutter web/mobile client for the Repeatro spaced repetition vocabulary app.<br />
    <a href="https://github.com/tomatoCoderq/repeatro"><strong>Backend Repo »</strong></a>
    <br />
    <a href="https://github.com/tomatoCoderq/repeatro/issues">Issues</a>
    &middot;
    <a href="https://github.com/tomatoCoderq/repeatro/pulls">Pull Requests</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#features">Features</a></li>
    <li><a href="#built-with">Built With</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

Repeatro Frontend is a Flutter-based web and mobile client for the Repeatro spaced repetition vocabulary learning platform. It provides a beautiful, responsive UI for managing decks, reviewing cards, and tracking your vocabulary progress.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Features

- Cross-platform: Web, Android, iOS, Desktop
- Deck and card management
- Spaced repetition review (SM2 algorithm, via backend)
- User authentication (JWT, via backend)
- Modern, responsive UI
- Light/dark theme support
- [Planned] Progress stats and charts
- [Planned] Import/export decks

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Built With

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Provider](https://pub.dev/packages/provider) (state management)
- [build_runner](https://pub.dev/packages/build_runner) (code generation)
- [json_serializable](https://pub.dev/packages/json_serializable) (model serialization)
- [http](https://pub.dev/packages/http) (API calls)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started

To get a local copy up and running, follow these steps.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart (comes with Flutter)

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/tomatoCoderq/repeatro.git
   cd repeatro/frontend
   ```
2. Install dependencies
   ```sh
   flutter pub get
   ```
3. Generate JSON serialization code
   ```sh
   flutter packages pub run build_runner build
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usage

To run the app locally:

- For web:
  ```sh
  flutter run -d web-server --web-port 8080
  ```
- For Android/iOS:
  ```sh
  flutter run
  ```

To build for production:
```sh
flutter build web
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Roadmap

- [ ] Progress stats and charts
- [ ] Import/export decks
- [ ] Offline support
- [ ] Localization
- [ ] PWA enhancements

See the [open issues][issues-url] for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contact

Maintainer: [@tomatoCoderq](https://github.com/tomatoCoderq)

Project Link: [https://github.com/tomatoCoderq/repeatro](https://github.com/tomatoCoderq/repeatro)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [Best-README-Template](https://github.com/othneildrew/Best-README-Template)
- [Img Shields](https://shields.io)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contributors

<a href="https://github.com/tomatoCoderq/repeatro/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=tomatoCoderq/repeatro" alt="Contributors" />
</a>

**Project contributors:**
- [@tomatoCoderq](https://github.com/tomatoCoderq)
- [@constabIe](https://github.com/constabIe)
- [@Kaghorz](https://github.com/Kaghorz)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/tomatoCoderq/repeatro.svg?style=for-the-badge
[contributors-url]: https://github.com/tomatoCoderq/repeatro/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/tomatoCoderq/repeatro.svg?style=for-the-badge
[forks-url]: https://github.com/tomatoCoderq/repeatro/network/members
[stars-shield]: https://img.shields.io/github/stars/tomatoCoderq/repeatro.svg?style=for-the-badge
[stars-url]: https://github.com/tomatoCoderq/repeatro/stargazers
[issues-shield]: https://img.shields.io/github/issues/tomatoCoderq/repeatro.svg?style=for-the-badge
[issues-url]: https://github.com/tomatoCoderq/repeatro/issues
[license-shield]: https://img.shields.io/github/license/tomatoCoderq/repeatro.svg?style=for-the-badge
[license-url]: https://github.com/tomatoCoderq/repeatro/blob/main/LICENSE