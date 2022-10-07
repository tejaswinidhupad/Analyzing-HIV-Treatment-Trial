# Analyzing-HIV-Treatment-Trial

![Current Version](https://img.shields.io/badge/version-v0.5-blue)
![GitHub contributors](https://img.shields.io/github/contributors/tejaswinidhupad/Analyzing-HIV-Treatment-Trial)
![GitHub stars](https://img.shields.io/github/stars/tejaswinidhupad/README-Template?style=social)
![GitHub activity](https://img.shields.io/github/commit-activity/w/tejaswinidhupad/Analyzing-HIV-Treatment-Trial?logoColor=brightgreen)

## Table of contents

- [Getting Started](#getting-started)
- [Running the App](#running-the-app)
- [Tools Required](#tools-required)
- [Development](#development)
- [Authors](#authors)
  - [Tejaswini Dhupad](#tejaswini-dhupad)
  - [Adam Broniewski](#adam-broniewski)
  - [Himanshu Choudhary](#himanshu-choudhary)
  - [Luiz Fonseca](#luiz-fonseca)
  - [Chun Han (Spencer) Li](#chun-han-spencer-li)
  - [Zyrako Musaj](#zyrako-musaj)
- [License](#license)
- [Acknowledgments](#acknowledgments)

The project follows the structure below:

```
	Child-Wasting-Prediction
	├── README.md
	├── LICENSE.md
	└── SAS
	└── src
		├── all executbale script files
	└── folder
		└── support documentation and project descriptions
	└── data
		├── raw
		└── processed
```
## Tools Required
- SAS

## Getting Started

1. 
2. Pipenv is used to manage dependencies. If you do not have pipenv installed, run the following:
    ```bash
    pip install pipx
    pip install pipenv
    ```
3. Install dependencies using the included pipfile. Run the following from the parent directory.
    ```bash
    pipenv install
    pipenv run clean_notebook
    ```
3. Once all dependencies are installed, we can run the main file.
    ```bash
    python main.py
    ```

This will run the full data-preperation, model building and prediction generation using the data provided in [/data](https://github.com/abroniewski/Child-Wasting-Prediction.git/data).

### Tools Required
SAS Studio

## Development

The objective of this project is to work with 

## Authors

#### Tejaswini Dhupad [GitHub](https://github.com/tejaswinidhupad) | [LinkedIn](https://www.linkedin.com/in/tejaswinidhupad/) 
#### Adam Broniewski [GitHub](https://github.com/abroniewski) | [LinkedIn](https://www.linkedin.com/in/abroniewski/) | [Website](https://adambron.com) 
#### Himanshu Choudhary
#### Luiz Fonseca
#### Chun Han (Spencer) Li 
#### Zyrako Musaj

## License

`Analyzing HIV Treatment Trial` is open source software [licensed as MIT][license].

## Acknowledgments

....

[//]: #
[license]: https://github.com/abroniewski/LICENSE.md
